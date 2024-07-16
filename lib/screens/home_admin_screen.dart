import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:bingoadmin/screens/componentes/drawer_admin.dart';

import 'package:flutter/material.dart';

class HomeAdminScreen extends StatelessWidget {

  const HomeAdminScreen({super.key});

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adicionar Vendedor!!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This traili
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