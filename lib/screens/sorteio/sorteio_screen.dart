import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/models/sorteios.dart';
import 'package:bingoadmin/screens/commons/mostra_erros.dart';
import 'package:bingoadmin/screens/sorteio/add_sorteio_screen.dart';
import 'package:bingoadmin/services/sorteio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SorteioScreen extends StatefulWidget {

  const SorteioScreen({super.key});

  @override
  State<SorteioScreen> createState() => _SorteioScreenState();
}

class _SorteioScreenState extends State<SorteioScreen> {

List<Sorteio> listaDeSorteio = [];


SorteioService _sorteioService =  SorteioService();

final Logger logger = Logger();

FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Sorteio'),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Consumer<Sorteios>(
        
        builder: (BuildContext context, Sorteios list, Widget? widget) {
          return RefreshIndicator(
            onRefresh: () async {
              refresh();
            },
            child: ListView.builder(
              itemCount: list.sorteios.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    onTap: (){
                      logger.i(" #ONTAP Clicou no item da lista");
                    },
                    onLongPress: () => {
                      logger.i(" #ONLONGPRESS Clicou no item da lista"),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SorteioAddScreen(
                            taskContext: context,
                            sorteio: list.sorteios[index],
                          ),
                        ),
                      ).then((value) => setState(() {
                            print('Recarregando a tela inicial');
                          }))
                    },
                    
                    leading: Icon(Icons.person_2),
                    title: Text(list.sorteios[index].nome + ' ('+ list.sorteios[index].local + ')'),
                  ),
                  onDismissed: (direction) {
                 
                    print("clicou no dimissed");
                    print(list.sorteios[index]);
                    remove(list.sorteios[index]);
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Clicou no Floating button de add sorteio");
          buttonFloatingClicked();  
          refresh();         
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
      
    );
  }

  // atualizar
  void refresh() async {    
    
    await _sorteioService.buscaTodos().then((sorteios) {
      Provider.of<Sorteios>(context, listen: false).setSorteios(sorteios);  
      print("Buscou a lista >>>>>>> "); 
    });
  }


// remover
 void remove(Sorteio sorteio) async {
   logger.i(sorteio.id);
   await _sorteioService.removerSorteioPorId(sorteio.id).then((retorno){
    logger.i(retorno);
   });
    refresh();
  }


  
buttonFloatingClicked() async {
  print('Click no botao de adicionar sorteio');
  Sorteio novoSorteio = Sorteio.empty();
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (contextNew) => SorteioAddScreen(
        taskContext: context,
        sorteio: novoSorteio,
      ),
    ),
  ).then((sucesso) {
      print("Sucesso total!!! ");
      print("Retorno do sucesso $sucesso");

      if (sucesso == DisposeStatus.error){
        mostraErrosTela(context, conteudo: "Erro ao salvar o sorteio");
      
      }
      if (sucesso==DisposeStatus.success){
       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorteio criado com  sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        print(">>>>> clicou no botao da home FIM 1");
        refresh();
      }



  });
}

     


// Mostra DIALOG //NAO USAR!!!
  showFormModal({Sorteio? model}) {
    // Labels à serem mostradas no Modal
    String labelTitle = "Adicionar Sorteio";
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
                    const InputDecoration(label: Text("Nome do Sorteio")),
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
                      // Criar um objeto Listin com as infos
                      Sorteio sorteio = Sorteio(
                        id: const Uuid().v1(),
                        nome: nameController.text,
                        local: "Vazio por enquanto...",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      // Usar id do model
                      if (model != null) {
                        sorteio.id = model.id;
                      }

                      // Salvar no Firestore
                      firestore
                          .collection("sorteio")
                          .doc(sorteio.id)
                          .set(sorteio.toMap());

                      // Atualizar a lista
                      refresh();

                      // Fechar o Modal
                      Navigator.pop(context);
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
