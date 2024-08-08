import 'package:flutter/material.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
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
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 11, 243)),
                        animationDuration: Duration(seconds: 1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 196, 196, 196),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: Text("Personal"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: Text("Personal"),
                ),
              ],
            )));
  }
}
