import 'package:flutter/material.dart';

class TextFieldPersonal extends StatelessWidget {
  const TextFieldPersonal(
      {super.key,
      required this.controller,
      required this.text,
      required this.typeInput,
      required this.onChanged});

  final TextEditingController controller;
  final String text;
  final TextInputType typeInput;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      onChanged: onChanged,
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
