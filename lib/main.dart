import 'package:arithmetic/views/levels_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Bruno Ace',
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const LevelsScreen(),
    );
  }
}
