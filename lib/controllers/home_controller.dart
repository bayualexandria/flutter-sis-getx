import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/utils/repositories/reporitories.dart';

class HomeController extends GetxController {
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;

  Future profileSchool() async {
    try {
      final response = await dio.get('$repositori/sekolah',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        return null;
      }
    } catch (e) {
      if (e.toString() == "Connection timed out") {
        Get.snackbar('message',
            "Koneksi ke server terputus! Mohon hubungi pihak administrator server.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
      throw Exception(e.toString());
    }
  }
}
