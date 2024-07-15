import 'package:bingoadmin/screens/componentes/drawer_admin.dart';
import 'package:bingoadmin/screens/vendedor_screen.dart';
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
        body: const Center(
          child: Text(
            'Teste Screen',
            style: TextStyle(fontSize: 24),
          ),
        ),
      )
    );
  }
}