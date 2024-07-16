import 'package:uuid/uuid.dart';

class Sorteio {
  String id;
  String nome;
  DateTime createdAt;
  DateTime updatedAt;

  Sorteio({
    required this.id,
    required this.nome,
    required this.createdAt,
    required this.updatedAt,
  });

  Sorteio.empty()
      : id = const Uuid().v1(),
        nome = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Sorteio.fromMap(Map<String, dynamic> map)
        : id = map['id'],
        nome = map['nome'],
        createdAt = DateTime.parse(map['createdAt']),
        updatedAt = DateTime.parse(map['updatedAt'])
        ;

        @override
        String toString() {
          return 'Sorteio(id: $id, nome: $nome, createdAt: $createdAt, updatedAt: $updatedAt)';
        }

 

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      
    };
    
  }


}
