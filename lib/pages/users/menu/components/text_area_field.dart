import 'package:flutter/material.dart';

class TextAreaFieldPersonal extends StatelessWidget {
  const TextAreaFieldPersonal({
    super.key,
    required this.controller,
    required this.text,
  });

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
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
