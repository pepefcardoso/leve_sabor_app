import 'package:flutter/material.dart';
import 'package:my_app/utils/tipografia.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;

  const CustomText({
    super.key,
    this.text = '',
    this.textStyle = Tipografia.corpo2Bold,
    this.textOverflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        style: textStyle,
        overflow: textOverflow,
      ),
    );
  }
}
