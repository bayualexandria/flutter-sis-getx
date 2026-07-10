import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis/utils/repositories/reporitories.dart';

class HomeController extends GetxController {
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;

  Future profileSchool() async {
    try {
      final response = await dio.get('$repositori/profile-sekolah',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      print('ini response profile school:');
      print(response);
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e.response?.data['message']);
      if (e.response?.data['message'] == "Service Unavailable") {
        return Get.snackbar(
            'message', "Server Down! Sistem API dalam perbaikan.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
      if (e.response?.statusCode == 530) {
        return Get.snackbar(
            'message', "Server terputus atau koneksi internet tidak aktif!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
    }
  }
}
