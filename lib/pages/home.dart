import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sis/pages/home/home.dart';
import './lists/list.dart';
import './messages/message.dart';
import './users/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff6366F1); // indigo modern
    const secondaryColor = Color(0xffA5B4FC);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomNavigationBar(
            items: buildNavigation,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedColor: primaryColor,
            unSelectedColor: Colors.grey,
            backgroundColor: Colors.white,
            iconSize: 28,
            strokeColor: Colors.transparent,
            scaleFactor: 0.2, // animasi zoom
          ),
        ),
      ),
    );
  }

  List<CustomNavigationBarItem> get buildNavigation {
    return <CustomNavigationBarItem>[
      itemNav(icon: HeroIcons.home, title: "Home"),
      itemNav(icon: HeroIcons.clock, title: "Jadwal"),
      itemNav(icon: HeroIcons.queueList, title: "Mapel"),
      itemNav(icon: HeroIcons.userCircle, title: "Profile"),
    ];
  }

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Home(),
      MenuMapelPage(),
      const Message(),
      const Profile(),
    ];
  }

  CustomNavigationBarItem itemNav({
    required HeroIcons icon,
    required String title,
  }) {
    return CustomNavigationBarItem(
      icon: HeroIcon(icon, style: HeroIconStyle.outline),
      selectedIcon: HeroIcon(
        icon,
        style: HeroIconStyle.solid,
        color: const Color(0xff6366F1),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
  //     centerTitle: true,
  //     backgroundColor: Colors.white,
  //     bottomOpacity: 0,
  //     elevation: 0,
  //     actions: [
  //       IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
  //     ],
  //     iconTheme: const IconThemeData(color: Color(0xFFD9D9D9)),
  //   );
  // }
}
