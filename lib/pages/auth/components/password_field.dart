import 'package:flutter/material.dart';

class PasswordFieldLogin extends StatefulWidget {
  const PasswordFieldLogin({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordFieldLogin> createState() => _PasswordFieldLoginState();
}

class _PasswordFieldLoginState extends State<PasswordFieldLogin> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
          label: const Text(
            "Password",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(157, 183, 0, 255)),
          ),
          suffixIcon: IconButton(
              onPressed: () => setState(() => showPassword = !showPassword),
              icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off))),
    );
  }
}
