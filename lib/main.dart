import 'dart:async';
import 'package:example_background/app_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/service_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceHelper serviceHelper = ServiceHelper();
  await serviceHelper.initializeService();
  // await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}
