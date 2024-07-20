import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestePontos extends StatelessWidget {
  const TestePontos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pontos da Conta",style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }
}