

import 'package:bingoadmin/models/Jogadores.dart';
import 'package:bingoadmin/models/jogador.dart';
import 'package:bingoadmin/services/jogador_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';


class JogadorScreen extends StatefulWidget {

  const JogadorScreen({super.key});

  @override
  State<JogadorScreen> createState() => _JogadorScreenState();
}

class _JogadorScreenState extends State<JogadorScreen> {


List<Jogador> listaDeJogadores = [];


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
      body: Consumer<Jogadores>(
        builder: (BuildContext context, Jogadores list, Widget? widget) {
          return ListView.builder(
            itemCount: list.jogadores.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                child: ListTile(
                  leading: Icon(Icons.person_2),
                  title: Text(list.jogadores[index].nome + ' ('+ list.jogadores[index].id + ')'),
                ),
                onDismissed: (direction) {
                 print("clicou no botao");
                },
              );
            },
          );
        },
      ),
   
    );
  }

//atualizar
  refresh() async {  
 //List<Jogador> jogadores = await _jogadorService.getJogadores();

  await _jogadorService.getJogadores().then((jogadores) {
    Provider.of<Jogadores>(context, listen: false).setJogadores(jogadores);
   
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
