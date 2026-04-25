import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'splash_screen.dart';
import 'package:connection_notifier/connection_notifier.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defau5ltContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
        connectionNotificationOptions: ConnectionNotificationOptions(
            alignment: AlignmentDirectional.topCenter, height: 40),
        child: GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff6366F1),
            ),
            scaffoldBackgroundColor: const Color(0xffF5F7FB),
          ),
          debugShowCheckedModeBanner: false,
          //  theme: ThemeData(fontFamily: 'Montserrat'),
          home: SplashScreen(),
        ));
  }
}
