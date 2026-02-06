import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

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
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.02,
                          vertical: size.width * 0.05),
                      width: double.infinity,
                      height: size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [],
                      ))),
              Padding(
                  padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.02,
                          vertical: size.width * 0.05),
                      width: double.infinity,
                      height: size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [],
                      ))),
              Padding(
                  padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.02,
                          vertical: size.width * 0.05),
                      width: double.infinity,
                      height: size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [],
                      ))),
              Padding(
                  padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.02,
                          vertical: size.width * 0.05),
                      width: double.infinity,
                      height: size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [],
                      ))),
            ],
          ),
        ),
      ],
    );
  }
}
