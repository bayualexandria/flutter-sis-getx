import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sis/controllers/users/user_controller.dart';
import 'package:sis/pages/users/personal/profile.dart';

class UserGender extends StatefulWidget {
  String? jenisKelaminIntern;
  UserGender({super.key, required this.jenisKelaminIntern});

  @override
  State<UserGender> createState() => _UserGenderState();
}

class _UserGenderState extends State<UserGender> {
  UserController userController = Get.put(UserController());
  bool checkboxValue1 = true;
  bool checkboxValue2 = true;
  String? jenisKelaminIntern;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Jenis Kelamin"),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 11, 243),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(
                      builder: (context) => const Personal(),
                      maintainState: false));
            },
            icon: const HeroIcon(HeroIcons.xMark)),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: ElevatedButton(
                    onPressed: () {
                      userController.genderUser();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            width: 3,
                            color: Colors.white), //border width and color
                        elevation: 0, //elevation of button

                        padding: const EdgeInsets.symmetric(
                            vertical: 0.5,
                            horizontal: 3.0) //content padding inside button
                        ),
                    child: const HeroIcon(
                      HeroIcons.check,
                      color: Color.fromARGB(255, 255, 11, 243),
                    ),
                  ))),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Laki-laki", style: TextStyle(color: Colors.black)),
                Radio(
                    activeColor: const Color.fromARGB(255, 255, 11, 243),
                    fillColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 11, 243)),
                    value: "Laki-laki",
                    groupValue: widget.jenisKelaminIntern == "Laki-laki"
                        ? "Laki-laki"
                        : 'Perempuan',
                    onChanged: (value) {
                      setState(() {
                        widget.jenisKelaminIntern = value;
                        userController.jenisKelamin = "Laki-laki";
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Perempuan", style: TextStyle(color: Colors.black)),
                Radio(
                    activeColor: const Color.fromARGB(255, 255, 11, 243),
                    fillColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 11, 243)),
                    value: "Perempuan",
                    groupValue: widget.jenisKelaminIntern == "Perempuan"
                        ? "Perempuan"
                        : 'Laki-laki',
                    onChanged: (value) {
                      setState(() {
                        widget.jenisKelaminIntern = value;
                        userController.jenisKelamin = "Perempuan";
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
