import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(157, 183, 0, 255),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Text(
                  "Ulangan Matematika",
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
