import 'package:flutter/material.dart';

class TextFieldPersonal extends StatelessWidget {
  const TextFieldPersonal({
    super.key,
    required this.controller,
    required this.text,
    required this.typeInput,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType typeInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      keyboardType: typeInput,
      decoration: InputDecoration(
        label: Text(
          text,
        ),
      ),
    );
  }
}
