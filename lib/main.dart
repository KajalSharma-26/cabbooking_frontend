import 'package:cabbooking_frontend/Auth/LoginScreen.dart';
import 'package:cabbooking_frontend/Auth/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Auth/SignupScreen.dart';

void main() {
  Get.put(Authcontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/login",

      getPages: [
        GetPage(name: "/login", page: () => const LoginScreen()),

        GetPage(name: "/signup", page: () => const SignupScreen()),
      ],
    );
  }
}
