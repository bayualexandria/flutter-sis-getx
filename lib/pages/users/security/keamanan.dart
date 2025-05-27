import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sis/controllers/users/user_controller.dart';
import 'package:sis/controllers/auth/authentication.dart';
import 'package:shimmer/shimmer.dart';

class Keamanan extends StatefulWidget {
  const Keamanan({super.key});

  @override
  State<Keamanan> createState() => _KeamananState();
}

class _KeamananState extends State<Keamanan> {
  UserController userController = Get.put(UserController());
  Authentication authentication = Get.put(Authentication());
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Keamanan"),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 11, 243),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            // Setting
            TextButton(
              onPressed: () {
                _dialogBuilderChangeEmail(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const HeroIcon(HeroIcons.envelope,
                          color: Color.fromARGB(255, 255, 11, 243)),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      const Text(
                        "Ganti Email",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 11, 243),
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const HeroIcon(
                    HeroIcons.chevronRight,
                    color: Color.fromARGB(255, 255, 11, 243),
                  )
                ],
              ),
            ),
            // Help
            TextButton(
              onPressed: () {
                _dialogBuilderChangePassword(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const HeroIcon(HeroIcons.key,
                          color: Color.fromARGB(255, 255, 11, 243)),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      const Text(
                        'Ubah Password',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 11, 243),
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const HeroIcon(
                    HeroIcons.chevronRight,
                    color: Color.fromARGB(255, 255, 11, 243),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modal Change Email
  Future<void> _dialogBuilderChangeEmail(BuildContext context) {
    final email = TextEditingController();
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            content: SizedBox(
              height: size.height * 0.18,
              width: size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ganti Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  FutureBuilder(
                      future: userController.user(),
                      builder: (context, data) {
                        if (data.hasData) {
                          return Text(
                            data.data['email'],
                            style: TextStyle(fontWeight: FontWeight.w600),
                          );
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white),
                          ),
                        );
                      }),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  TextFormField(
                    controller: email,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    enabled: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text(
                        "Email",
                      ),
                    ),
                  )
                ],
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Colors.red),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Colors.green),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  userController.changeEmail(email: email);
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  // Modal Change Password
  Future _dialogBuilderChangePassword(BuildContext context) {
    final password = TextEditingController();

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            content: SizedBox(
              height: size.height * 0.18,
              width: size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ubah Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                        label: const Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(157, 183, 0, 255)),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => showPassword = !showPassword),
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  )
                ],
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Colors.red),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Colors.green),
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  userController.changePassword(password: password);
                  setState(() {
                    Navigator.of(context).pop();
                    authentication.logout();
                  });
                },
              ),
            ],
          );
        });
  }
}
