import 'package:flutter/material.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class NotaComIcone extends StatelessWidget {
  final String? nota;
  final int? quantidadeDeAvaliacoes;

  const NotaComIcone({
    super.key,
    required this.nota,
    required this.quantidadeDeAvaliacoes,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle estiloTexto = Tipografia.corpo2;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: CustomColors.verde3,
          size: estiloTexto.fontSize! + 2,
        ),
        const SizedBox(width: 4.0),
        Text(
          nota ?? '',
          style: estiloTexto,
        ),
        const SizedBox(width: 4.0),
        Text(
          '(${quantidadeDeAvaliacoes?.toString() ?? ''})',
          style: estiloTexto,
        ),
      ],
    );
  }
}
