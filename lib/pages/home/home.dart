import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/controllers/home_controller.dart';
import 'package:sis/utils/repositories/reporitories.dart';
import '../../controllers/users/user_controller.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shimmer/shimmer.dart';

final List<String> imgList = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlogsxIACrSMcDYNSrv5_Fb1dqMCfMDhmn9JyB_xu72QRd5lZqBfAEW1184oBtoh4OPM0&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK11qj1jVYk51Z-h4XbwXJCp1sJcE7y3t0NA&s',
];
final List<Widget> imageSliders = imgList
    .map((item) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ],
        )))
    .toList();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();
  final userController = Get.put(UserController());
  final homeController = Get.put(HomeController());
  final repositori = APIEndPoints().baseUrlImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: size.height * 0.05,
          left: 15,
          right: 15,
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(157, 183, 0, 255),
          Color.fromARGB(218, 55, 0, 255),
          Color.fromARGB(255, 0, 140, 255),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 1,
                  right: 1,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang Di \nSistem Informasi Siswa",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        FutureBuilder(
                            future: homeController.profileSchool(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data['nama_sekolah'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white));
                              }
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 70),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white),
                                ),
                              );
                            })
                      ],
                    ),
                    FutureBuilder(
                        future: userController.user(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final imageUrl =
                                snapshot.data['siswa']['image_profile'];
                            final String repositori =
                                APIEndPoints().baseUrlImage;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 11, 243),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      imageUrl != null
                                          ? '$repositori$imageUrl'
                                          : 'https://api-sis.bayualexandria.site/assets/images/logo-pendidikan.png',
                                    ),
                                    radius: 24,
                                  ),
                                ),
                                Text(
                                  snapshot.data['siswa']['nama'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white),
                                )
                              ],
                            );
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 24),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white),
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Dashboard',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/logo-pendidikan.png'),
                      width: 60,
                    ),
                    FutureBuilder(
                        future: homeController.profileSchool(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.35,
                                        child: Text(
                                          snapshot.data['nama_sekolah'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "No Telephone : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Text(snapshot.data['no_telp'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Color.fromARGB(255, 76, 76, 76)),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Akreditasi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black)),
                                    Text(snapshot.data['akreditasi'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: snapshot
                                                        .data['akreditasi'] ==
                                                    'A'
                                                ? Color.fromARGB(
                                                    255, 48, 253, 2)
                                                : (snapshot.data[
                                                            'akreditasi'] ==
                                                        'B'
                                                    ? Color.fromARGB(
                                                        255, 0, 60, 255)
                                                    : Color.fromARGB(
                                                        255, 255, 0, 0))))
                                  ],
                                )
                              ],
                            );
                          }
                          return Text("");
                        })
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Informasi',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 5.0,
                      height: 5.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.white)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Menu',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.users,
                            size: 25,
                            color: Color.fromARGB(255, 3, 141, 221),
                          ),
                          titleSub: "Siswa",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.buildingOffice2,
                            size: 25,
                            color: Color.fromARGB(255, 163, 255, 87),
                          ),
                          titleSub: "Sekolah",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.academicCap,
                            size: 25,
                            color: Color.fromARGB(255, 193, 106, 252),
                          ),
                          titleSub: "Kelulusan",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.calendar,
                            size: 25,
                            color: Color.fromARGB(255, 221, 241, 38),
                          ),
                          titleSub: "Jadwal Ujian",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.creditCard,
                            size: 25,
                            color: Color.fromARGB(255, 41, 196, 216),
                          ),
                          titleSub: "Hasil Ujian",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.chatBubbleLeftEllipsis,
                            size: 25,
                            color: Color.fromARGB(255, 33, 137, 206),
                          ),
                          titleSub: "Mapel",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.user,
                            size: 25,
                            color: Color.fromARGB(255, 231, 51, 51),
                          ),
                          titleSub: "Guru",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.wallet,
                            size: 25,
                            color: Color.fromARGB(255, 38, 143, 241),
                          ),
                          titleSub: "Kelas",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.clipboard,
                            size: 25,
                            color: Color.fromARGB(255, 216, 41, 70),
                          ),
                          titleSub: "Pengumuman",
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.exclamationCircle,
                            size: 25,
                            color: Color.fromARGB(255, 137, 33, 206),
                          ),
                          titleSub: "Informasi",
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ));
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon(
      {super.key,
      required this.size,
      required this.icon,
      required this.titleSub});

  final Size size;
  final HeroIcon icon;
  final titleSub;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.2,
      child: Column(
        children: [
          SizedBox(width: double.infinity, child: icon),
          SizedBox(
            width: double.infinity,
            child: Text(
              titleSub,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: Color.fromARGB(167, 0, 0, 0)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
