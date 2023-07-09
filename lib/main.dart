import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/app_colors.dart';
import 'views/digits_screen.dart';
import 'viewmodels/digits_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final DigitsViewModel digitsViewModel = Get.put(DigitsViewModel());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Bruno Ace',
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: DigitsScreen(),
    );
  }
}
