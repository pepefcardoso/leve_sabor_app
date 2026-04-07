import 'package:flutter/material.dart';
import 'package:my_app/utils/custom_colors.dart';

class BotaoContornado extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? boxBorder;
  final VoidCallback? onTap;

  const BotaoContornado({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.boxBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          border: boxBorder ??
              Border.all(
                width: 1.5,
                color: CustomColors.cinza1,
              ),
        ),
        child: child,
      ),
    );
  }
}
