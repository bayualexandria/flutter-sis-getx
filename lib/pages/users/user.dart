import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import '../../controllers/auth/authentication.dart';
import '../../controllers/users/user_controller.dart';
import '../../pages/users/menu/profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Authentication authentication = Get.put(Authentication());
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
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
        FutureBuilder(
            future: userController.user(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final imageUrl = snapshot.data['image_profile'];
                return RefreshIndicator(
                  onRefresh: () {
                    return userController.user();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Text(
                              snapshot.data['nama'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text(
                              snapshot.data['nis'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                            Text(
                              snapshot.data['no_hp'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 10),
                            )
                          ],
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 11, 243),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              imageUrl != null
                                  ? 'http://192.168.1.6:8000/storage/$imageUrl'
                                  : 'https://kemahasiswaan.umpp.ac.id/upload/default.png',
                            ),
                            radius: 39,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.only(
            top: 180,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.02, vertical: size.width * 0.05),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: false).push(
                          MaterialPageRoute(
                              builder: (context) => const Personal(),
                              maintainState: false));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.user,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Personal',
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
                  // Menu
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.bars3,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Pilihan',
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
                  // Security
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.lockClosed,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Kemanan',
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
                  // Setting
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.wrench,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Pengaturan',
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
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.exclamationCircle,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Bantuan',
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
                  // Logout
                  TextButton(
                    onPressed: () {
                      _dialogBuilder(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(HeroIcons.arrowLeftStartOnRectangle,
                                color: Color.fromARGB(255, 255, 11, 243)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Keluar',
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
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Center(
                    child: Text(
                      "Version 1.0.0",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 11, 243)),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Apakah anda ingin keluar dari aplikasi!',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ya'),
                onPressed: () {
                  authentication.logout();
                },
              ),
            ],
          );
        });
  }
}
