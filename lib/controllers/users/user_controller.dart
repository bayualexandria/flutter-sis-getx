import 'package:dio/dio.dart';
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
      final response = await dio.get('$repositori/siswa/$noInduk',
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
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
