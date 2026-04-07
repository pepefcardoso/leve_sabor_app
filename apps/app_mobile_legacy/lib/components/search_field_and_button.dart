import 'package:flutter/material.dart';
import 'package:my_app/components/custom_icon_card_button.dart';
import 'package:my_app/utils/custom_colors.dart';

class SearchFieldAndButton extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final String? hintText;

  const SearchFieldAndButton({
    super.key,
    required this.controller,
    this.onPressed,
    this.hintText,
  });

  @override
  State<SearchFieldAndButton> createState() => _SearchFieldAndButtonState();
}

class _SearchFieldAndButtonState extends State<SearchFieldAndButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(4.0),
      child: TextFormField(
        controller: widget.controller,
        onFieldSubmitted: (_) => widget.onPressed?.call(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconCardButton(
                icon: Icons.search,
                iconColor: CustomColors.verde1,
                onPressed: widget.onPressed,
                padding: const EdgeInsets.all(8.0),
                iconSize: 24.0,
              ),
              const SizedBox(width: 12.0),
            ],
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}
