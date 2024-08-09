import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/controllers/users/user_controller.dart';
import 'package:sis/pages/users/menu/components/text_area_field.dart';
import 'package:sis/pages/users/menu/components/text_field.dart';
import 'package:sis/utils/repositories/reporitories.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  UserController userController = Get.put(UserController());
  final repositori = APIEndPoints().baseUrlImage;
  final nis = TextEditingController();
  final name = TextEditingController();
  final jenisKelamin = TextEditingController();
  final noHp = TextEditingController();
  final alamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Personal"),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 11, 243),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {},
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 11, 243),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              width: 3,
                              color: Colors.white), //border width and color
                          elevation: 0, //elevation of button

                          padding: EdgeInsets.symmetric(
                              vertical: 0.5,
                              horizontal: 3.0) //content padding inside button
                          ),
                    ))),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: userController.user(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          nis.text = snapshot.data['siswa']['nis'];
                          name.text = snapshot.data['siswa']['nama'];
                          jenisKelamin.text = snapshot.data['siswa']['jenis_kelamin'];
                          noHp.text = snapshot.data['siswa']['no_hp'];
                          alamat.text = snapshot.data['siswa']['alamat'];
                          final imageUrl = snapshot.data['siswa']['image_profile'];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 11, 243),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          imageUrl != null
                                              ? '$repositori$imageUrl'
                                              : 'https://kemahasiswaan.umpp.ac.id/upload/default.png',
                                        ),
                                        radius: 78,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                TextFormField(
                                  controller: nis,
                                  readOnly: true,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 71, 71, 71),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    label: Text(
                                      "No Induk Siswa",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFieldPersonal(
                                  controller: name,
                                  text: 'Nama Lengkap',
                                  typeInput: TextInputType.text,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFieldPersonal(
                                  controller: jenisKelamin,
                                  text: 'Jenis Kelamin',
                                  typeInput: TextInputType.text,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFieldPersonal(
                                  controller: noHp,
                                  text: 'No. Handphone',
                                  typeInput: TextInputType.number,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextAreaFieldPersonal(
                                  controller: alamat,
                                  text: 'Alamat',
                                )
                              ],
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 255, 11, 243),
                          ),
                        );
                      })
                ],
              ),
            )));
  }
}
