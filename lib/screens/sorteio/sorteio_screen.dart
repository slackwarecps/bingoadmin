import 'package:bingoadmin/models/sorteio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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



}
