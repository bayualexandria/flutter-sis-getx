import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../auth/authentication.dart';
import '../../utils/repositories/reporitories.dart';

class UserController extends GetxController {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;
  Authentication authentication = Authentication();

  Future user() async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');
    try {
      final response = await dio.get('$repositori/user/$noInduk/siswa',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      print(response);
      if (response.data['data'] != null) {
        return response.data['data'];
      }
      if (response.data['message'] == 'Token tidak valid') {
        authentication.removeToken();
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
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
    return null;
  }
}
