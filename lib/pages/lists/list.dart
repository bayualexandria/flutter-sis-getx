import 'package:flutter/material.dart';

class MenuMapelPage extends StatelessWidget {
  final List<Map<String, dynamic>> mapel = [
    {"nama": "Matematika", "icon": Icons.calculate, "warna": Colors.blue},
    {"nama": "Bahasa Indonesia", "icon": Icons.menu_book, "warna": Colors.red},
    {"nama": "IPA", "icon": Icons.science, "warna": Colors.green},
    {"nama": "IPS", "icon": Icons.public, "warna": Colors.orange},
    {"nama": "Agama", "icon": Icons.mosque, "warna": Colors.purple},
    {"nama": "Olahraga", "icon": Icons.sports_soccer, "warna": Colors.teal},
  ];

  MenuMapelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Mapel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: mapel.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = mapel[index];
            return GestureDetector(
              onTap: () {
                print("Klik ${item['nama']}");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: item['warna'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      item['nama'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
