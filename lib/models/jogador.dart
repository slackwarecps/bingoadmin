

import 'package:uuid/uuid.dart';

class Jogador {
  String id;
  String nome;
  double saldo; // Change the type from Double to double
  DateTime createdAt;
  DateTime updatedAt;

  Jogador({
    required this.id,
    required this.nome,
    required this.saldo,
    required this.createdAt,
    required this.updatedAt,
  });

  Jogador.empty()
      : id = Uuid().v1(),
        nome = "",
        saldo = 0.0,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'saldo': saldo.toString(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  @override
  String toString() {
    return "$nome \n  saldo:  $nome \n created_at: $createdAt\nupdated_at: $updatedAt";
  }
}
