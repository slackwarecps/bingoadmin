import 'package:uuid/uuid.dart';

class Sorteio {
String id;
String nome;
String local;
DateTime createdAt;
DateTime updatedAt;

//Construtor
Sorteio({
  required this.id,
  required this.nome,
  required this.local,
  required this.createdAt,
  required this.updatedAt,
});

Sorteio.empty()
  : id = const Uuid().v1(),
    nome = "",
    local = "",
    createdAt = DateTime.now(),
    updatedAt = DateTime.now();

 // converte o json para um objeto Sorteio
 // vai ser utilizado quando buscar os dados na api de Sorteio
Sorteio.fromMap(Map<String, dynamic> map)
    : id = map['id'],
    nome = map['nome'] ?? "",
    local = map['nome'] ?? "",
    createdAt = map['createdAt']==null? DateTime.now() : DateTime.parse(map['createdAt']),
    updatedAt = map['updatedAt']==null? DateTime.now() : DateTime.parse(map['updatedAt'])
    ; 

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'nome': nome,
    'local': nome,
    'createdAt': createdAt.toString(),
    'updatedAt': updatedAt.toString(),  
  };
}

@override
String toString() {
  return 'Sorteio(id: $id, nome: $nome, createdAt: $createdAt, updatedAt: $updatedAt)';
}

}
