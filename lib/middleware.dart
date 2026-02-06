import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/pages/home/home.dart';
import 'package:sis/pages/intro.dart';
import 'controllers/auth/authentication.dart';

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Get.find();
    return FutureBuilder(
        future: authentication.hasToken(),
        builder: (context, snapshoot) {
          if (!snapshoot.hasData) {
            return const Intro();
          }
          return const Home();
        });
  }
}
