import 'package:arithmetic/viewmodels/digits_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/levels_list.dart';
import '../utils/svg_strings.dart';
import '../widgets/level_button_widget.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DigitsViewModel digitsViewModel = Get.put(DigitsViewModel());
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final deviceHeight = deviceSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: deviceHeight / 20,
            horizontal: deviceWidth / 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight / 10,
              ),
              Image.asset(
                'assets/arithmetic.png',
                height: deviceHeight / 5,
              ),
              SizedBox(
                height: deviceHeight / 10,
              ),
              LevelButtons(
                levelIcon: SvgStrings.easy,
                title: 'Easy',
                onTap: () {
                  digitsViewModel.initializeLevel(LevelsList.easy);
                },
              ),
              SizedBox(
                height: deviceHeight / 25,
              ),
              LevelButtons(
                levelIcon: SvgStrings.medium,
                title: 'Medium',
                onTap: () {
                  digitsViewModel.initializeLevel(LevelsList.medium);
                },
              ),
              SizedBox(
                height: deviceHeight / 25,
              ),
              LevelButtons(
                levelIcon: SvgStrings.hard,
                title: 'Hard',
                onTap: () {
                  digitsViewModel.initializeLevel(LevelsList.hard);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
