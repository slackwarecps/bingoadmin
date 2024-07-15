import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:bingoadmin/screens/componentes/drawer_admin.dart';
import 'package:bingoadmin/screens/vendedor_screen.dart';
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
        child: Text(
          'Home Admin',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}