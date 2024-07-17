
import 'package:bingoadmin/models/vendedor.dart';
import 'package:bingoadmin/services/vendedor_service.dart';

import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class AddJogadorScreen extends StatefulWidget {


  final Vendedor vendedor;
  final bool isEditing;
  const AddJogadorScreen( {
    Key? key,
    required this.vendedor,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<AddJogadorScreen> createState() => salvarSorteio();
}

class salvarSorteio extends State<AddJogadorScreen> {
  
    final Logger logger = Logger();
    

  TextEditingController nomeController = TextEditingController();
VendedorService _vendedorService =  VendedorService();

  @override
  void initState() {
    nomeController.text = widget.vendedor.nome;
    nomeController.text = "Batata Frita 123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Vendedor"),
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
  _vendedorService.adiciona(Vendedor(id: "123",nome: nome)).then((retorno){
    print("salvando bota clicado...");
    print(retorno);
    Navigator.pop(context, DisposeStatus.success);
  });

 
  
   
  }

  
}



enum DisposeStatus { exit, error, success }
