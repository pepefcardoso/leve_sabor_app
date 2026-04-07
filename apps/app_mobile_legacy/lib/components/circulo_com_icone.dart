import 'package:flutter/material.dart';
import 'package:my_app/utils/custom_colors.dart';

class CirculoComIcone extends StatelessWidget {
  final IconData icone;
  final double tamanho;

  const CirculoComIcone({
    super.key,
    this.icone = Icons.construction,
    this.tamanho = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: CustomColors.verde2,
      radius: tamanho,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        width: tamanho,
        height: tamanho,
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          icone,
          color: CustomColors.verde1,
          size: tamanho,
        ),
      ),
    );
  }
}
