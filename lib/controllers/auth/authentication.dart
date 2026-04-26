import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sis/pages/intro.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/home.dart';
import '../../utils/repositories/reporitories.dart';

class Authentication extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;
  static final _googleSignIn = GoogleSignIn();

  Future<void> loginEndPoint() async {
    Map body = {'username': username.text, 'password': password.text};
    try {
      final response = await dio.post('$repositori/auth/login',
          data: body,
          options: Options(
              followRedirects: false,
              contentType: "application/json",
              validateStatus: (status) {
                return status! < 500;
              }));
      print('pesan response $response');

      if (response.data['status'] == 401) {
        final messages = response.data['message'];
        final username = messages['username'] ?? '';
        final password = messages['password'] ?? '';

        Get.snackbar(
          'message',
          '$username \n$password',
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            borderRadius: 12,
            margin: EdgeInsets.all(16),
            duration: Duration(seconds: 2),
            colorText: Colors.white,

            // efek floating
            snackStyle: SnackStyle.FLOATING,

            // animasi masuk
            animationDuration: Duration(milliseconds: 500),

            // blur + transparan biar modern
            backgroundGradient: LinearGradient(
              colors: [const Color.fromARGB(255, 255, 114, 114), Colors.red],
            ),

            // efek icon seperti SweetAlert
            icon: Icon(Icons.close, color: Colors.white),

            // shadow biar keliatan “ngambang”
            boxShadows: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
        );
        return response.data['message'];
      }
      if (response.data['status'] == 403) {
        Get.snackbar('message', response.data['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            borderRadius: 12,
            margin: EdgeInsets.all(16),
            duration: Duration(seconds: 2),
            colorText: Colors.white,

            // efek floating
            snackStyle: SnackStyle.FLOATING,

            // animasi masuk
            animationDuration: Duration(milliseconds: 500),

            // blur + transparan biar modern
            backgroundGradient: LinearGradient(
              colors: [const Color.fromARGB(255, 255, 114, 114), Colors.red],
            ),

            // efek icon seperti SweetAlert
            icon: Icon(Icons.close, color: Colors.white),

            // shadow biar keliatan “ngambang”
            boxShadows: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ));
        return response.data['message'];
      }
      await storage.write(key: 'token', value: response.data['accessToken']);
      await storage.write(
          key: 'username', value: response.data['user']['username']);
      Get.off(const HomePage());
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data['message'] == "Service Unavailable") {
        Get.snackbar('message', "Server Down! Sistem API dalam perbaikan.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
      if (e.response?.statusCode == 530) {
        Get.snackbar(
            'message', "Server terputus atau koneksi internet tidak aktif!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
      final errors = e.response?.statusCode;

      Get.snackbar('message', "Link URL API tidak valid!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(255, 255, 193, 193),
          borderRadius: 12,
          margin: EdgeInsets.all(16),
          duration: Duration(seconds: 2),
          colorText: Colors.white,

          // efek floating
          snackStyle: SnackStyle.FLOATING,

          // animasi masuk
          animationDuration: Duration(milliseconds: 500),

          // blur + transparan biar modern
          backgroundGradient: LinearGradient(
            colors: [const Color.fromARGB(255, 255, 114, 114), Colors.red],
          ),

          // efek icon seperti SweetAlert
          icon: Icon(Icons.close, color: Colors.white),

          // shadow biar keliatan “ngambang”
          boxShadows: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
          titleText: const Text(
            'Pesan Error',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ));

      // throw Exception(e.toString());
    }
  }

  Future<String?> token() async {
    final response = await storage.read(key: 'token');
    return response;
  }

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      Get.off(const HomePage());
      return true;
    } else {
      Get.off(const Intro());
      return false;
    }
  }

  Future removeToken() async {
    var token = await storage.deleteAll();

    Get.off(const LoginPage());
    return token;
  }

  Future<bool> logout() async {
    final token = await storage.read(key: 'token');
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
    await _googleSignIn.signOut();
    await DefaultCacheManager().emptyCache();
    Get.off(const LoginPage());
    return true;
  }

  Future loginGoogle() async {
    final user = await _googleSignIn.signIn();
    final id = user?.id;
    final name = user?.displayName;
    final email = user?.email;

    try {
      final response =
          await dio.get('$repositori/login/google/$email/$id/$name',
              options: Options(
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                  },
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  }));

      if (response.data['status'] == 403) {
        await _googleSignIn.signOut();

        Get.snackbar('message', response.data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
        return response.data['message'];
      }
      await storage.write(key: 'token', value: response.data['accessToken']);
      await storage.write(
          key: 'username', value: response.data['user']['username']);

      Get.off(const HomePage());
      return response.data;
    } on DioException catch (e) {
      await _googleSignIn.signOut();
      if (e.response?.data['message'] == "Service Unavailable") {
        Get.snackbar('message', "Server Down! Sistem API dalam perbaikan.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      }
      if (e.response?.statusCode == 530) {
        Get.snackbar(
            'message', "Server terputus atau koneksi internet tidak aktif!",
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
