import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:bingoadmin/screens/componentes/drawer_admin.dart';

import 'package:flutter/material.dart';

class TesteScreen extends StatelessWidget {
  const TesteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Scaffold(
        drawer: DrawerAdmin(context),
        appBar: AppBar(
          title: const Text('Teste Screen'),
        ),
        body: Center(
          
          child: Column(
          
            children: [

              CircularProgressIndicator(),
                 Text(
                'Teste Screen color Primary',
                style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.surface),
              ),
              Text(
                'Teste headlineMedium',
                style:  Theme.of(context).textTheme.headlineMedium,
              ),
                Text(
                'Teste headlineLarge',
                style:  Theme.of(context).textTheme.headlineLarge,
              ),
                Text(
                'Teste headlineSmall',
                style:  Theme.of(context).textTheme.headlineSmall,
              ),
                      Text(
                'Teste Screen',
                style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 20, width: 20),
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),

                      Text(
                'Paddding',
                style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
              ),
              Padding(padding: EdgeInsets.all(20)),
                Text(
                'Container',
                style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
              ),
                   Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),

                      Text(
                'Teste Screen',
                style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      )
    );
  }
}