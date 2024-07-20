import 'package:bingoadmin/screens/componentes/box_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TesteAcoes extends StatelessWidget {
  const TesteAcoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Ações do Bingo Admin",style: Theme.of(context).textTheme.titleMedium,),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MeuBoxCard(boxContent: MeuConteudo(icon: Icon(Icons.mobile_friendly), text: "Depositar"),),
            MeuBoxCard(boxContent: MeuConteudo(icon: Icon(Icons.mobile_friendly), text: "Transferir"),),
            InkWell(
              onTap: (){
                print("clicou");
              },
              child: BoxCard(boxContent: MeuConteudo(icon: Icon(Icons.search), text: "Ler"),),
              ),
          ],
        )
      ],
    );
  }
}

class MeuBoxCard extends StatelessWidget {
  final Widget boxContent;
  const MeuBoxCard({
    super.key, required this.boxContent,
  });

  @override
  Widget build(BuildContext context){
        return Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                boxShadow: kElevationToShadow[3],
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
            ),
            child: boxContent,
        );
    }
}

// um template que vai retornar um icone e um texto
// inkwell é um widget que permite que você adicione um gesto a um widget filho semelhante a um botao
class MeuConteudo extends StatelessWidget {
  final Icon icon;
  final String text; 
  const MeuConteudo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      child: Column(
        children: [
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          Text(text),
        ],
      ),
    );
  }
}

