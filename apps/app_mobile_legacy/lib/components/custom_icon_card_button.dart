import 'package:flutter/material.dart';
import 'package:my_app/utils/custom_colors.dart';

class CustomIconCardButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? cardColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  final IconData? icon;
  final double? iconSize;

  const CustomIconCardButton({
    super.key,
    this.onPressed,
    this.cardColor = CustomColors.claro,
    this.iconColor = CustomColors.escuro,
    this.padding = const EdgeInsets.all(6.0),
    this.icon = Icons.arrow_back_ios_new_rounded,
    this.iconSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        surfaceTintColor: cardColor,
        child: Padding(
          padding: padding!,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
