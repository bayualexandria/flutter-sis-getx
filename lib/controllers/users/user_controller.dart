import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sis/pages/auth/login_page.dart';
import 'package:sis/pages/users/personal/profile.dart';
import '../auth/authentication.dart';
import '../../utils/repositories/reporitories.dart';

class UserController extends GetxController {
  late String? jenisKelamin;
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

      if (response.data['data'] != null) {
        return response.data['data'];
      }
      if (response.data['message'] == 'Token tidak valid') {
        authentication.removeToken();
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
    return null;
  }

  Future getUser() async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');
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

    return response.data['data'];
  }

  Future<void> updateUser(
      {required TextEditingController nama,
      required TextEditingController nohp,
      required TextEditingController alamat}) async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');

    Map body = {'nama': nama.text, 'no_hp': nohp.text, 'alamat': alamat.text};
    try {
      final response = await dio.post('$repositori/siswa/$noInduk',
          data: body,
          options: Options(
              followRedirects: false,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              validateStatus: (status) {
                return status! < 500;
              }));

      Get.off(const Personal());
      Get.snackbar('message', response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 200, 255, 195),
          colorText: Colors.green,
          icon: const HeroIcon(
            HeroIcons.check,
            color: Colors.green,
          ),
          titleText: const Text(
            'Pesan Success',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ));
      return response.data;
    } catch (e) {
      return e.printError();
    }
  }

  Future<void> genderUser() async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');
    Map body = {
      'jenis_kelamin': jenisKelamin,
    };
    try {
      final response = await dio.post('$repositori/siswa/$noInduk',
          data: body,
          options: Options(
              followRedirects: false,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              validateStatus: (status) {
                return status! < 500;
              }));

      Get.off(const Personal());
      Get.snackbar('message', response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 200, 255, 195),
          colorText: Colors.green,
          icon: const HeroIcon(
            HeroIcons.check,
            color: Colors.green,
          ),
          titleText: const Text(
            'Pesan Success',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ));
      return response.data;
    } catch (e) {
      return e.printError();
    }
  }

  // Change Email
  Future<void> changeEmail({required TextEditingController email}) async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');

    Map body = {
      'email': email.text,
    };

    try {
      final response = await dio.post('$repositori/siswa/changeEmail/$noInduk',
          data: body,
          options: Options(
              followRedirects: false,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              validateStatus: (status) {
                return status! < 500;
              }));
      await dio.get('$repositori/logout',
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
      await storage.deleteAll();
      Get.off(const LoginPage());
      Get.snackbar('message', response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 200, 255, 195),
          colorText: Colors.green,
          titleText: const Text(
            'Pesan Success',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ));
    } catch (e) {
      return e.printError();
    }
  }

  // Change Password
  Future<void> changePassword({required TextEditingController password}) async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');

    Map body = {
      'password': password.text,
    };

    try {
      final response =
          await dio.post('$repositori/siswa/changePassword/$noInduk',
              data: body,
              options: Options(
                  followRedirects: false,
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $token',
                  },
                  validateStatus: (status) {
                    return status! < 500;
                  }));
      await dio.get('$repositori/logout',
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
      await storage.deleteAll();
      Get.off(const LoginPage());
      Get.snackbar('message', response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 200, 255, 195),
          colorText: Colors.green,
          titleText: const Text(
            'Pesan Success',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ));
      return response.data;
    } catch (e) {
      return e.printError();
    }
  }
}
