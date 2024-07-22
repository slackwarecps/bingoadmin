import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/services/sorteio_service.dart';
import 'package:flutter/material.dart';


class SorteioAddScreen extends StatefulWidget {
  const SorteioAddScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<SorteioAddScreen> createState() => _SorteioAddScreenState();
}

class _SorteioAddScreenState extends State<SorteioAddScreen> {
  TextEditingController localController = TextEditingController();
  TextEditingController nomeController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

    final SorteioService _sorteioService = SorteioService();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Sorteio'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                             Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o local do Sorteio';
                        }
                        return null;
                      },
                      controller: localController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Local',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome do sorteio';
                        }
                        return null;
                      },
                      controller: nomeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
               
              
                 
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(nomeController.text);
                        print(localController.text);
                        

                   
                        _sorteioService.adicionarSorteio(Sorteio(
                          id: "",
                          nome: nomeController.text,
                          local: localController.text,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ));


                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando um novo Sorteio'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Adicionar Sorteio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
