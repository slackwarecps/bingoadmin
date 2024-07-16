import 'package:uuid/uuid.dart';

class Vendedor {
  String id;
  String nome;

//Construtor
  Vendedor({
    required this.id,
    required this.nome,
  });

  Vendedor.empty()
      : id = Uuid().v1(),
        nome = "";

  Vendedor.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return 'Vendedor(id: $id, nome: $nome)';
  }


}
