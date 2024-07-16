import 'package:uuid/uuid.dart';

class Jogador {
  String id;
  String nome;
  DateTime createdAt;
  DateTime updatedAt;

  Jogador({
    required this.id,
    required this.nome,
    required this.createdAt,
    required this.updatedAt,
  });

  Jogador.empty()
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

  @override
  String toString() {
    return "$nome \ncreated_at: $createdAt\nupdated_at: $updatedAt";
  }
}