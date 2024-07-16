import 'package:bingoadmin/models/sorteio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SorteioScreen extends StatefulWidget {

  const SorteioScreen({super.key});

  @override
  State<SorteioScreen> createState() => _SorteioScreenState();
}

class _SorteioScreenState extends State<SorteioScreen> {
List<Sorteio> listaDeSorteio = [];



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
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Sorteio'),
      ),
      body: (1==2)? Center(child: Text("Nenhum item ainda")):  RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: listaDeSorteio.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listaDeSorteio[index].nome),
              subtitle: Text(listaDeSorteio[index].createdAt.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  remove(listaDeSorteio[index]);
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
    

    List<Sorteio> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("sorteio").get();

    for (var doc in snapshot.docs) {
      temp.add(Sorteio.fromMap(doc.data()));
    }

    setState(() {
      listaDeSorteio = temp;
    });
  }


//remover
 void remove(Sorteio model) {
    firestore.collection('sorteio').doc(model.id).delete();
    refresh();
  }


//Mostra Formulario
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
                      Sorteio listin = Sorteio(
                        id: const Uuid().v1(),
                        nome: nameController.text,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      // Usar id do model
                      if (model != null) {
                        listin.id = model.id;
                      }

                      // Salvar no Firestore
                      firestore
                          .collection("sorteio")
                          .doc(listin.id)
                          .set(listin.toMap());

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
