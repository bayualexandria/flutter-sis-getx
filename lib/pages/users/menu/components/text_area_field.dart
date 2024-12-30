import 'package:flutter/material.dart';

class TextAreaFieldPersonal extends StatelessWidget {
  const TextAreaFieldPersonal({
    super.key,
    required this.controller,
    required this.text,
    required this.onChanged
  });

  final TextEditingController controller;
  final String text;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
        label: Text(
          text,
        ),
      ),
    );
  }
}
