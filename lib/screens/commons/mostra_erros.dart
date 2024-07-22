import 'package:flutter/material.dart';

mostraErrosTela(
  BuildContext context, {
  required String conteudo,
  String titulo = "Um problema aconteceu",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(children: [
          const Icon(
            Icons.warning,
            color: Colors.brown,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.brown,
            ),
          ),
        ]),
        content: Text(conteudo),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    },
  );
}