import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/pages/users/security/keamanan.dart';
import 'package:sis/utils/repositories/reporitories.dart';
import '../../controllers/auth/authentication.dart';
import '../../controllers/users/user_controller.dart';
import 'personal/profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Authentication authentication = Get.put(Authentication());
  UserController userController = Get.put(UserController());
  final repositori = APIEndPoints().baseUrlImage;

  late Future userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = userController.user();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6366F1), Color(0xff8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FutureBuilder(
            future: userController.user(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final imageUrl = snapshot.data['siswa']['image_profile'];

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          imageUrl != null
                              ? '$repositori$imageUrl'
                              : 'https://kemahasiswaan.umpp.ac.id/upload/default.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data['siswa']['nama'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            snapshot.data['email'],
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 130,
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  menuItem(
                    icon: Icons.person,
                    title: "Personal",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Personal()));
                    },
                  ),
                  menuItem(
                    icon: Icons.lock,
                    title: "Keamanan",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Keamanan()));
                    },
                  ),
                  menuItem(
                    icon: Icons.settings,
                    title: "Pengaturan",
                    onTap: () {},
                  ),
                  menuItem(
                    icon: Icons.help,
                    title: "Bantuan",
                    onTap: () {},
                  ),
                  menuItem(
                    icon: Icons.logout,
                    title: "Keluar",
                    onTap: () => _dialogBuilder(context),
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

  Widget menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xffEEF2FF),
          child: Icon(icon, color: Color(0xff6366F1)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    bool loadingLogin = true;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(loadingLogin == true ? 'Logout' : ''),
            content: Text(
              loadingLogin == true
                  ? 'Apakah anda ingin keluar dari aplikasi!'
                  : '',
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text(
                      'Tidak',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text(
                      'Ya',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      authentication.logout();
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              )
            ],
          );
        });
  }
}
