import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:heroicons/heroicons.dart';
import 'package:sis/pages/auth/login_page.dart';

import 'package:sis/pages/users/personal/profile.dart';
import 'package:sis/pages/users/security/keamanan.dart';
import '../auth/authentication.dart';
import '../../utils/repositories/reporitories.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/form_data.dart' as dio_form_data;
import 'package:dio/src/multipart_file.dart' as dio_multipart_file;

class UserController extends GetxController {
  late String? jenisKelamin;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  static final _googleSignIn = GoogleSignIn();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;
  Authentication authentication = Authentication();
  XFile? imageFile;

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
      print(response.data);
      if (response.data['data'] != null) {
        return response.data['data'];
      }
      if (response.data['message'] == 'Token tidak valid') {
        authentication.removeToken();
      } else {
        return null;
      }
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
      throw Exception(e.toString());
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
      throw Exception(e.toString());
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

      if (response.data['status'] == 403) {
        Get.off(const Keamanan());
        Get.snackbar(
            'message', 'Email yang anda masukan sudah terdaftar pada user lain',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
      } else {
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
        await _googleSignIn.disconnect();
        Get.off(const LoginPage());
        Get.snackbar('message', response.data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 200, 255, 195),
            colorText: Colors.green,
            titleText: const Text(
              'Pesan Success',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ));
      }
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
      throw Exception(e.toString());
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
      Get.snackbar('message', response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 200, 255, 195),
          colorText: Colors.green,
          titleText: const Text(
            'Pesan Success',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ));
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
      await _googleSignIn.disconnect();
      Get.off(const LoginPage());
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
      throw Exception(e.toString());
    }
  }

  Future<void> updateImageProfile() async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'username');
    final formData = dio_form_data.FormData.fromMap({
      'image_profile': await dio_multipart_file.MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.name),
    });

    try {
      final response = await dio.post('$repositori/siswa/$noInduk',
          data: formData,
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
      print(response);

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
      return Get.off(const Personal());
    } on DioException catch (e) {
      print(e.response);
      Get.snackbar('message', 'File Maksimal 2 MB',
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
