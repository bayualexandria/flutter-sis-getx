import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/authentication.dart';
import 'components/password_field.dart';
import 'components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool showPassword = false;
  bool loadingLogin = true;

  Authentication authentication = Get.put(Authentication());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(157, 183, 0, 255),
              Color.fromARGB(218, 55, 0, 255),
              Color.fromARGB(255, 0, 140, 255),
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo-pendidikan.png'),
                  width: 60,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                const Text(
                  "Sistem Informasi Siswa",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 220, bottom: 50, left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.02,
                    vertical: size.width * 0.05),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const Text(
                      "Halaman Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black38),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    Form(
                        child: Column(children: [
                      TextFieldLogin(controller: authentication.username),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      PasswordFieldLogin(controller: authentication.password),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 40),
                        width: size.width * 0.8,
                        height: size.height * 0.07,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                loadingLogin = false;
                                Timer(const Duration(seconds: 5), () {
                                  authentication.loginEndPoint();
                                  Timer(const Duration(seconds: 1), () {
                                    setState(() {
                                      loadingLogin = true;
                                    });
                                  });
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor:
                                    const Color.fromARGB(82, 136, 93, 255)),
                            child: loadingLogin == true
                                ? const Text("Login",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 33, 224),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))
                                : const CircularProgressIndicator(
                                    color: Colors.white),
                          ),
                        ),
                      )
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
