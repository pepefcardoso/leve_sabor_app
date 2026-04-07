import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/utils/custom_colors.dart';
import 'package:my_app/utils/tipografia.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: Tipografia.titulo2),
          const SizedBox(height: 4.0),
        ],
        Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(4.0),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onFieldSubmitted: onSubmitted,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              errorStyle: Tipografia.corpo2Bold.copyWith(color: Colors.red),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(icon, color: CustomColors.verde3),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
