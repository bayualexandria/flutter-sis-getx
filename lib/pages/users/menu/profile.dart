import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/controllers/users/user_controller.dart';
import 'package:sis/pages/users/menu/components/text_area_field.dart';
import 'package:sis/pages/users/menu/gender.dart';
import 'package:sis/utils/repositories/reporitories.dart';
import 'package:heroicons/heroicons.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  UserController userController = Get.put(UserController());
  final repositori = APIEndPoints().baseUrlImage;
  final nis = TextEditingController();
  final nama = TextEditingController();
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
                padding: const EdgeInsets.only(right: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    userController.updateUser(
                        nohp: noHp, nama: nama, alamat: alamat);
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
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 11, 243),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
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
                          nama.text = snapshot.data['siswa']['nama'];
                          noHp.text = snapshot.data['siswa']['no_hp'];
                          alamat.text = snapshot.data['siswa']['alamat'];

                          final String jns =
                              snapshot.data['siswa']['jenis_kelamin'];
                          final imageUrl =
                              snapshot.data['siswa']['image_profile'];
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextFormField(
                                    controller: nis,
                                    readOnly: true,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 71, 71, 71),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "No Induk Siswa",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextFormField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    // ignore: unrelated_type_equality_checks
                                    onChanged: (value) => value != nama,
                                    controller: nama,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "Nama Lengkap",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: false)
                                        .push(MaterialPageRoute(
                                            builder: (context) => UserGender(
                                                  jenisKelaminIntern: jns,
                                                ),
                                            maintainState: false));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Jenis Kelamin",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data['siswa']
                                                ['jenis_kelamin'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const HeroIcon(
                                            HeroIcons.chevronRight,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextFormField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    controller: noHp,
                                    onChanged: (value) => value != noHp,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "No Handphone",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextAreaFieldPersonal(
                                    onChanged: (value) => value != alamat,
                                    controller: alamat,
                                    text: 'Alamat',
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return const Center(
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
