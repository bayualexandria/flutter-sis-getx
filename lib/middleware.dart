import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth/authentication.dart';
import 'pages/auth/login_page.dart';
import 'pages/home.dart';

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Get.find();
    return FutureBuilder(
        future: authentication.hasToken(),
        builder: (context, snapshoot) {
          if (!snapshoot.hasData) {
            return const LoginPage();
          }
          return const HomePage();
        });
  }
}
