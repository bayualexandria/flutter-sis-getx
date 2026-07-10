import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sis/controllers/users/user_controller.dart';
import 'package:sis/pages/users/personal/components/text_area_field.dart';
import 'package:sis/pages/users/personal/gender.dart';
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
  bool _loaded = false;

  XFile? imageFile;

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
                        noHp: noHp, nama: nama, alamat: alamat);
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
                      future: userController.getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (!_loaded) {
                            nis.text = snapshot.data['nis'];
                            nama.text = snapshot.data['name'];
                            noHp.text = snapshot.data['no_hp'];
                            alamat.text = snapshot.data['alamat'];

                            _loaded = true;
                          }
                          final imageUrl = snapshot.data['image_profile'];
                          final String jns = snapshot.data['jenis_kelamin'];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 15),
                            child: Column(
                              children: [
                                Stack(
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
                                    Positioned(
                                        top: 120,
                                        left: 100,
                                        right: 0,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              getImageCamera();
                                              if (userController.imageFile !=
                                                  null) {
                                                userController
                                                    .updateImageProfile();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        0, 255, 255, 255),
                                                side: const BorderSide(
                                                    width: 3,
                                                    color: Color.fromARGB(
                                                        0, 255, 255, 255)),
                                                elevation: 0,
                                                padding:
                                                    const EdgeInsets.all(10)),
                                            child: const Icon(Icons.camera_alt,
                                                color: Color.fromARGB(
                                                    255, 119, 119, 119),
                                                size: 30))),
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
                                    onChanged: (value) => value != nama,
                                    controller: nama,
                                    enabled: true,
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
                                            snapshot.data['jenis_kelamin'],
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
                                    keyboardType: TextInputType.number,
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

getImageCamera() async {
  final picker = ImagePicker();
  await picker.pickImage(source: ImageSource.gallery).then((value) {
    if (value != null) {
      Get.find<UserController>().imageFile = value;
      Get.find<UserController>().updateImageProfile();
    } else {
      return;
    }
  });
}
