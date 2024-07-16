
import 'package:bingoadmin/models/vendedor.dart';

import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class AddVendedorScreen extends StatefulWidget {


  final Vendedor vendedor;
  final bool isEditing;
  const AddVendedorScreen({
    Key? key,
    required this.vendedor,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<AddVendedorScreen> createState() => salvarSorteio();
}

class salvarSorteio extends State<AddVendedorScreen> {
    final Logger logger = Logger();

  TextEditingController nomeController = TextEditingController();


  @override
  void initState() {



    nomeController.text = widget.vendedor.nome;
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
              print('salvando');
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: nomeController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }

  
}

enum DisposeStatus { exit, error, success }
