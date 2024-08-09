import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:sis/utils/repositories/reporitories.dart';
import '../../controllers/users/user_controller.dart';
import 'package:heroicons/heroicons.dart';

final List<String> imgList = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlogsxIACrSMcDYNSrv5_Fb1dqMCfMDhmn9JyB_xu72QRd5lZqBfAEW1184oBtoh4OPM0&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdeK9Uy2Dht8UMOxvrdu0vlAKX5F0WfHpAl0XhXgaOHn-1OpTBYK9zHtnl7IUeAV4Q5lQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_zyke4tMI2xr2dZMnObSiRxHnbcP4wLwkoZvwlnZ2OxbfdND-Hp2tw7nVZIpXxpayJVw&usqp=CAU',
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
                // child: Text(
                //   'No. ${imgList.indexOf(item)} image',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
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
  final CarouselController _controller = CarouselController();
  final userController = Get.put(UserController());
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
              FutureBuilder(
                  future: userController.user(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final imageUrl = snapshot.data['siswa']['image_profile'];
                      return Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 1,
                          right: 1,
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  "Selamat Datang \nSistem Informasi Siswa",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Column(
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
                                          : 'https://kemahasiswaan.umpp.ac.id/upload/default.png',
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
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              // const Text(
              //   'Dashboard',
              //   style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontSize: 15,
              //       color: Colors.white),
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // Container(
              //   padding: const EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.white),
              // ),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
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
                          title: "Siswa",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.buildingOffice2,
                            size: 25,
                            color: Color.fromARGB(255, 163, 255, 87),
                          ),
                          title: "Sekolah",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.academicCap,
                            size: 25,
                            color: Color.fromARGB(255, 193, 106, 252),
                          ),
                          title: "Kelulusan",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.calendar,
                            size: 25,
                            color: Color.fromARGB(255, 221, 241, 38),
                          ),
                          title: "Jadwal Ujian",
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
                          title: "Hasil Ujian",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.chatBubbleLeftEllipsis,
                            size: 25,
                            color: Color.fromARGB(255, 33, 137, 206),
                          ),
                          title: "Mapel",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.user,
                            size: 25,
                            color: Color.fromARGB(255, 231, 51, 51),
                          ),
                          title: "Guru",
                        ),
                        MenuIcon(
                          size: size,
                          icon: const HeroIcon(
                            HeroIcons.wallet,
                            size: 25,
                            color: Color.fromARGB(255, 38, 143, 241),
                          ),
                          title: "Kelas",
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
                          title: "Pengumuman",
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
                          title: "Informasi",
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
      {super.key, required this.size, required this.icon, required this.title});

  final Size size;
  final HeroIcon icon;
  final title;
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
              title,
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
