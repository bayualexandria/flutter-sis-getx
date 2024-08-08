import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth/authentication.dart';
import 'middleware.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Authentication authentication = Get.put(Authentication());
  Future<void> initializeSettings() async {
    await Future.delayed(Duration(seconds: 10));
    authentication.hasToken();

    //Simulate other services for 3 seconds
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else
            return Middleware();
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return const Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/logo-pendidikan.png'),
            width: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                    color: Color.fromARGB(157, 183, 0, 255)),
              ),
              Text('Loading...'),
            ],
          ),
        ],
      ),
    ));
  }
}
