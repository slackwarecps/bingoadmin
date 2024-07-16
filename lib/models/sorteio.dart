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
    return "$nome \ncreated_at: $createdAt\nupdated_at: $updatedAt";
  }

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': nome,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      
    };
  }


}
