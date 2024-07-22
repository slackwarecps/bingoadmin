import 'dart:io';

import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/screens/commons/confirmation_dialog.dart';
import 'package:bingoadmin/screens/commons/mostra_erros.dart';
import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:bingoadmin/screens/componentes/drawer_admin.dart';
import 'package:bingoadmin/services/sorteio_service.dart';

import 'package:flutter/material.dart';

class HomeAdminScreen extends StatefulWidget {

  const HomeAdminScreen({super.key});

  

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
SorteioService _sorteioService = SorteioService();

  @override
  Widget build(BuildContext context) {

      
      
    return Scaffold(
      drawer: DrawerAdmin(context),
      appBar: AppBar(
        title: const Text('Home Admin'),
      ),
      body: const Center(
        child: Column(
          children: [
            CardExample(),
           Card(child: _SampleCard(cardName: 'Elevated Card')),
            Card.filled(child: _SampleCard(cardName: 'Filled Card')),

              Card.outlined(child: _SampleCard(cardName: 'Outlined Card')),

             Text(
              'Home Admin',
              style: TextStyle(fontSize: 24),
            ),
           
            Text(
              'Diversos',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){


         print("clicou no botao da home");

        // mostraErrosTela(context, conteudo: "teste de conteudo");
        buttonAtualizaSorteioClick();

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }

 void buttonAtualizaSorteioClick() {
  print(">>>>> clicou no botao da home INICIO");

    // final snackBar = SnackBar(
    //     content: Row(
    //       children: [
    //         CircularProgressIndicator(),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Text('Atualizando...'),
    //       ],
        
        
    //   ));

    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
 
    _sorteioService.updateSorteio("669e5a1fd2f43b485726fb9e", Sorteio.empty()).then((sucesso){
      print("Sucesso total!!! ");
      print(sucesso);
      final snackBar = SnackBar(
        content: Text('Sucesso!'),
        backgroundColor: Colors.blue,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print(">>>>> clicou no botao da home FIM 1");
    })
    .catchError((e){
      print("OPS!  PEGOU O ERRO !!!");
      print(e.message);
      print("-----------------");

     mostraErrosTela(context, conteudo: e.message);



      print(">>>>> clicou no botao da home FIM 2");
    }
    );




 
  }
}


class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('Novos Bingos '),
              subtitle: Text('Localize novos bingos acontecendo na sua região.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('COMPRAR CARTELAS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('DAR UMA OLHADA'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}