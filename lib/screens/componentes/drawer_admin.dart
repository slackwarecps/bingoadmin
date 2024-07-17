
import 'package:flutter/material.dart';

Drawer DrawerAdmin(BuildContext context) {
  return Drawer(
    
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.pink,
          ),
          child: const Text(
            'Bingo Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        ListTile(
          title: const Text('Sorteio'),
          leading: Icon(Icons.casino),
          onTap: () {
            Navigator.pushNamed(context, 'sorteios');
          },
          
        ),
         ListTile(
          title: const Text('Vendedor'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.pushNamed(context, 'vendedores');
          },          
        ),

  ListTile(
          title: const Text('Jogador'),
          leading: Icon(Icons.co_present_outlined),
          onTap: () {
            Navigator.pushNamed(context, 'jogadores');
          },          
        ),

         ListTile(
          title: const Text('Cartelas'),
          leading: Icon(Icons.card_travel),
          onTap: () {
            Navigator.pushNamed(context, 'cartelas');
          },          
        ),
           ListTile(
          title: const Text('Realizar Sorteio Manual'),
          leading: Icon(Icons.access_alarm),
          onTap: () {
            Navigator.pushNamed(context, 'sorteio-manual');
          },          
        ),

        ListTile(
          title: const Text('Testes'),
          leading: Icon(Icons.access_alarm),
          onTap: () {
            Navigator.pushNamed(context, 'teste');
          },          
        ),

        ListTile(
          title: const Text('Diversos'),
          leading: Icon(Icons.access_alarm),
          onTap: () {
            Navigator.pushNamed(context, 'diversos');
          },          
        ),

      ],
    ),
  );
}