
import 'package:bingoadmin/models/vendedor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:uuid/uuid.dart';

class VendedorScreen extends StatefulWidget {

  const VendedorScreen({super.key});

  @override
  State<VendedorScreen> createState() => _VendedorScreenState();
}

class _VendedorScreenState extends State<VendedorScreen> {
List<Vendedor> listaDeVendedor = [];
final Logger logger = Logger();


FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    logger.v("Verbose log");

    logger.d("Debug log");

    logger.i("Info log");

    logger.w("Warning log");

    logger.e("Error log");

    logger.wtf("What a terrible failure log");
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i("Clicou em adicionar vendedor");
          Navigator.pushNamed(context, 'vendedores-add');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Vendedores'),
      ),
      body: (1==2)? Center(child: Text("Nenhum item ainda")):  RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: listaDeVendedor.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listaDeVendedor[index].nome),
              subtitle: Text("adasd"),
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
    

    List<Vendedor> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("vendedor").get();

    for (var doc in snapshot.docs) {
      temp.add(Vendedor.fromMap(doc.data()));
    }

    setState(() {
      listaDeVendedor = temp;
    });
  }


//remover
 void remove(Vendedor model) {
    firestore.collection('vendedor').doc(model.id).delete();
    refresh();
  }


//Mostra Formulario
  showFormModal({Vendedor? model}) {
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
                      // Criar um objeto Listin com as infos
                      Vendedor vendedor = Vendedor(
                        id: const Uuid().v1(),
                        nome: nameController.text,
                      );

                      // Usar id do model
                      if (model != null) {
                        vendedor.id = model.id;
                      }

                      // Salvar no Firestore
                      firestore
                          .collection("vendedor")
                          .doc(vendedor.id)
                          .set(vendedor.toMap());

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
