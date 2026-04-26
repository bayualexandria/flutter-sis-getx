import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/controllers/home_controller.dart';
import 'package:sis/utils/repositories/reporitories.dart';
import '../../controllers/users/user_controller.dart';
import 'package:heroicons/heroicons.dart';

final List<String> imgList = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlBQ29NNI2Hd1F4rYzkjj6p0tEqR1lyWbEYQ&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyUVma9B3iWxEJPRmq8p3UW0b5w-hgHO8gqg&s',
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
                      Color(0xff6a11cb),
                      Color(0xff2575fc),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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
  final int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();
  final userController = Get.put(UserController());
  final homeController = Get.put(HomeController());
  final repositori = APIEndPoints().baseUrlImage;
  late Future profileFuture;
  late Future userFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = homeController.profileSchool();
    userFuture = userController.user();
  }

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
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff667eea),
                      Color(0xff764ba2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat Datang 👋",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder(
                            future: userFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data['siswa']['nama'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Container(
                                  height: 15,
                                  width: 120,
                                  color: Colors.white24);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.notifications, color: Colors.white),
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xffeef2ff),
                      child: Icon(Icons.school, color: Colors.blue),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: FutureBuilder(
                        future: profileFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['nama_sekolah'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Akreditasi ${snapshot.data['akreditasi']}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            );
                          }
                          return Container(height: 20, color: Colors.grey[200]);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // const Text(
              //   'Informasi',
              //   style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontSize: 15,
              //       color: Colors.white),
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // CarouselSlider(
              //   items: imageSliders,
              //   carouselController: _controller,
              //   options: CarouselOptions(
              //       autoPlay: true,
              //       enlargeCenterPage: true,
              //       aspectRatio: 2.0,
              //       onPageChanged: (index, reason) {
              //         setState(() {
              //           _current = index;
              //         });
              //       }),
              // ),
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
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(

                  children: [
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: const [
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.users), titleSub: "Siswa"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.buildingOffice2),
                            titleSub: "Sekolah"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.academicCap),
                            titleSub: "Kelulusan"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.calendar),
                            titleSub: "Jadwal"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.creditCard),
                            titleSub: "Hasil"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
                            titleSub: "Mapel"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.user), titleSub: "Guru"),
                        MenuIcon(
                            icon: HeroIcon(HeroIcons.wallet),
                            titleSub: "Kelas"),
                      ],
                    ),
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
  const MenuIcon({
    super.key,
    required this.icon,
    required this.titleSub,
  });

  final HeroIcon icon;
  final String titleSub;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 8),
          Text(
            titleSub,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
