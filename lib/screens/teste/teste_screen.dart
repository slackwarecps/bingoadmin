import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:bingoadmin/screens/componentes/drawer_admin.dart';
import 'package:bingoadmin/screens/teste/teste_acoes.dart';
import 'package:bingoadmin/screens/teste/teste_pontos.dart';
import 'package:bingoadmin/tema/theme_colors.dart';

import 'package:flutter/material.dart';

class TesteScreen extends StatelessWidget {
  const TesteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Screen',
      
      home: Scaffold(
        drawer: DrawerAdmin(context),
        appBar: AppBar(
          title: const Text('Teste Screen'),
        ),
        body: Center(
          
          child: Column(
          
            children: [
              Text("pois é..."),
              LinearProgressIndicator(value: 0.0,minHeight: 25,),
              HeaderFabao(),
              TesteAcoes(),
               TestePontos(),
                LinearProgressIndicator(minHeight: 25,),
                Text("Alguma coisa escrita aqui para ser colocado dentro da tela \$1500.00. bla bla bla e la vamos nos."),
                TextButton(onPressed: (){
                  print('voce cl;icou');
                  
                }, child: Text("Clique aqui"),),

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


class HeaderFabao extends StatelessWidget {
const HeaderFabao({ Key? key }) : super(key: key);
@override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ThemeColors.headerGradient
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              // Text('\$1000.00', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                Text.rich(
                  TextSpan(
                    text: '\$',
                    children: <TextSpan>[
                      TextSpan(
                        text: '1000.00',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              Text('Balanço disponível'),
            ],),
            Icon(Icons.account_circle, size: 42,),
          ],
        ),
      ),
    );
  }
}