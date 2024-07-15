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
      : id = Uuid().v1(),
        nome = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  Sorteio.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        createdAt = DateTime.tryParse(map['created_at']) ?? DateTime.now(),
        updatedAt = DateTime.tryParse(map['updated_at']) ?? DateTime.now();

  @override
  String toString() {
    return "$nome \ncreated_at: $createdAt\nupdated_at: $updatedAt";
  }
}
