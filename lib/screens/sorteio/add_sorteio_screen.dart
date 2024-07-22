import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/screens/commons/mostra_erros.dart';
import 'package:bingoadmin/services/sorteio_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';


class SorteioAddScreen extends StatefulWidget {
  
  const SorteioAddScreen({Key? key, required this.taskContext, required this.sorteio}) : super(key: key);

  final BuildContext taskContext;

  //Solicitando o sorteio na construcao do widget
  final Sorteio sorteio;


  @override
  State<SorteioAddScreen> createState() => _SorteioAddScreenState();
}

class _SorteioAddScreenState extends State<SorteioAddScreen> {

  Logger logger = Logger();

  bool _isEditando = false;

 
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
 

  logger.i("EVENTO: CRIOU A TELA DE ADD SORTEIO");

  logger.i(widget.sorteio);

  if (widget.sorteio.nome==""){
    logger.i("Adicionando um novo sorteio");
    nomeController.text = "";
    localController.text = "";

     localController.text = "Campinas";
  nomeController.text = "Laranjinha";
    _isEditando = false;
  }else{ 
    logger.i("Editando um sorteio");
    nomeController.text = widget.sorteio.nome;
    localController.text = widget.sorteio.local;
    _isEditando = true;
  }


    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: _isEditando ? const Text('Atualizar Sorteio'): const Text('Novo Sorteio') ,
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
                      buttonSalvarSorteioClicked();
                    },
                    child: _isEditando?Text('Atualizar o Sorteio'):Text('Adicionar Sorteio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

void buttonSalvarSorteioClicked() async{
  logger.i("EVENTO: BOTAO SALVAR SORTEIO CLICADO");

   if (_formKey.currentState!.validate()) {
      print(nomeController.text);
      print(localController.text);
      

      if (_isEditando==true){
          _sorteioService.updateSorteio(widget.sorteio.id, Sorteio(
              id: widget.sorteio.id,
              nome: nomeController.text,
              local: localController.text,
              createdAt: widget.sorteio.createdAt,
              updatedAt: DateTime.now(),
            ));

                ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Atualizando o sorteio'),
          backgroundColor: Colors.green,
        ),
      );
      
      }else{                             
        await _sorteioService.adicionarSorteio(Sorteio(
              id: "",
              nome: nomeController.text,
              local: localController.text,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )).then((value){
              if (value){
                print("terminou de salvar na API ");
                print(value);
              }
              Navigator.pop(context, DisposeStatus.success);
            }).catchError((erro){
              Navigator.pop(context, DisposeStatus.error);
            });

      
      }

    }

}

}


enum DisposeStatus { exit, error, success }