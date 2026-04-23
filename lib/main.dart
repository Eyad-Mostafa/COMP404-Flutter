import 'package:comp404_flutter/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/auth/presentation/screens/start_screen.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'COMP 404',
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}

