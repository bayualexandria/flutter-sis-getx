import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text(
            "No.Induk Siswa",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(157, 183, 0, 255)),
          ),
          suffixIcon: Icon(Icons.person)),
    );
  }
}
