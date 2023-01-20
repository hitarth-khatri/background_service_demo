import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.offNamed(Routes.routeHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(50),
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
