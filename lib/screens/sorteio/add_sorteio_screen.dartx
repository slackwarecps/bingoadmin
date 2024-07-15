import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/services/sorteio_service.dart';
import 'package:flutter/material.dart';

class AddSorteioScreen extends StatefulWidget {
  final Sorteio sorteio;
  final bool isEditing;
  const AddSorteioScreen({
    Key? key,
    required this.sorteio,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<AddSorteioScreen> createState() => salvarSorteio();
}

class salvarSorteio extends State<AddSorteioScreen> {
  TextEditingController nomeController = TextEditingController();

  @override
  void initState() {
    nomeController.text = widget.sorteio.nome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Sorteio"),
        actions: [
          IconButton(
            onPressed: () {
              salvarSorteio(context);
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

  salvarSorteio(BuildContext context) async {
    SorteioService sorteioService = SorteioService();
    widget.sorteio.nome = nomeController.text;

    if (widget.isEditing) {
      sorteioService.edit(widget.sorteio.id, widget.sorteio).then((value) {
        if (value) {
          Navigator.pop(context, DisposeStatus.success);
        } else {
          Navigator.pop(context, DisposeStatus.error);
        }
      });
    } else {
      sorteioService.register(widget.sorteio).then((value) {
        if (value) {
          Navigator.pop(context, DisposeStatus.success);
        } else {
          Navigator.pop(context, DisposeStatus.error);
        }
      });
    }
  }
}

enum DisposeStatus { exit, error, success }
