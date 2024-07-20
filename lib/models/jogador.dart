

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
        : id = const Uuid().v1(),
          nome = "",
          saldo = 0.0,
          createdAt = DateTime.now(),
          updatedAt = DateTime.now();


Jogador.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      nome = map['nome'],
      saldo = (map['saldo'] is int) ? (map['saldo'] as int).toDouble() : (map['saldo'] is String) ? double.parse(map['saldo']) : map['saldo'],
      createdAt = map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),  
      updatedAt = map['updatedAt']  != null ? DateTime.parse(map['updatedAt']) : DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'saldo': saldo.toString(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }

  @override
  String toString() {
    return "$nome \n  saldo:  $nome \n created_at: $createdAt\nupdated_at: $updatedAt";
  }
}
