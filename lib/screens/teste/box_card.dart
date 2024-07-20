import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MeuBoxCard extends StatelessWidget {
  final  boxContent;

  const MeuBoxCard({super.key, required this.boxContent});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[3],
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: boxContent,
    );
  }
}