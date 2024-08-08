import 'dart:async';
// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/home.dart';
import '../../utils/repositories/reporitories.dart';

class Authentication extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;

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

      print(response);
      if (response.data['status'] == 401) {
        final messages = response.data['message'];
        final username = messages['username'] ?? '';
        final password = messages['password'] ?? '';

        Get.snackbar(
          'message',
          '$username \n$password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 193, 193),
          colorText: Colors.red,
          titleText: const Text(
            'Pesan Error',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        );
        return response.data['message'];
      }
      if (response.data['status'] == 403) {
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
    } catch (e) {
      return e.printError();
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
      Get.off(const LoginPage());
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
    final response = await dio.get('$repositori/logout',
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
    await storage.deleteAll();
    Get.off(const LoginPage());
    print(response);
    return true;
  }
}
