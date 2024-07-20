

import 'package:bingoadmin/models/jogador.dart';
import 'package:bingoadmin/services/jogador_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';


class JogadorScreen extends StatefulWidget {

  const JogadorScreen({super.key});

  @override
  State<JogadorScreen> createState() => _JogadorScreenState();
}

class _JogadorScreenState extends State<JogadorScreen> {
List<Jogador> listaDeVendedor = [];
final Logger logger = Logger();

JogadorService _jogadorService =  JogadorService();


FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
  
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i("Clicou em adicionar jogador");
          Navigator.pushNamed(context, 'jogadores-add');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Jogadores'),
      ),
      body: (1==2)? Center(child: Text("Nenhum item ainda")):  RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          refresh();
        },
        child: ListView.builder(
          itemCount: listaDeVendedor.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listaDeVendedor[index].nome),
              subtitle: Text("ID: ${listaDeVendedor[index].id} "),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  remove(listaDeVendedor[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

//atualizar
  refresh() async {
    

    List<Jogador> temp = [];

  
    await _jogadorService.getJogadores().then((value) {
      setState(() {
        listaDeVendedor = value;
      });
    });

  

  }


//remover
 void remove(Jogador model) {

    logger.i(model.id);
   _jogadorService.remove(model.id).then((retorno){
    logger.i(retorno);

   });
    refresh();
  }

  void adicionaVendedor() {
    showFormModal();
  }


//Mostra Formulario
  showFormModal({Jogador? model}) {
    // Labels à serem mostradas no Modal
    String labelTitle = "Adicionar Vendedor";
    String labelConfirmationButton = "Salvar";
    String labelSkipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController nameController = TextEditingController();

    // Caso esteja editando
    if (model != null) {
      labelTitle = "Editando ${model.nome}";
      nameController.text = model.nome;
    }

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,

      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(labelTitle),
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nome do Vendedor")),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(labelSkipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logger.i("NAO FEZ NADA POR ENQUANTO...");
                    
                    },
                    child: Text(labelConfirmationButton),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }




}
