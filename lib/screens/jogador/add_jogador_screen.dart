
import 'package:bingoadmin/models/jogador.dart';
import 'package:bingoadmin/models/vendedor.dart';
import 'package:bingoadmin/services/jogador_service.dart';


import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class AddJogadorScreen extends StatefulWidget {


  final Jogador jogador;
  final bool isEditing;
  const AddJogadorScreen( {
    Key? key,
    required this.jogador,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<AddJogadorScreen> createState() => salvarSorteio();
}

class salvarSorteio extends State<AddJogadorScreen> {
  
    final Logger logger = Logger();
    

  TextEditingController nomeController = TextEditingController();
JogadorService _jogadorService =  JogadorService();

  @override
  void initState() {
    nomeController.text = widget.jogador.nome;
    nomeController.text = "Batata Frita 123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar jogador"),
        actions: [
          IconButton(
            onPressed: () {
              buttonSalvarCliked(nomeController.text);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  void buttonSalvarCliked(String nome) {
  _jogadorService.adiciona(Jogador(id: "123",nome: nome, saldo: 47,createdAt: DateTime.now(),
                        updatedAt: DateTime.now())).then((retorno){
    print("salvando bota clicado...");
    print(retorno);
    Navigator.pop(context, DisposeStatus.success);
  });

 
  
   
  }

  
}



enum DisposeStatus { exit, error, success }
