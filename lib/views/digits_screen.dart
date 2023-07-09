import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/svg_strings.dart';
import '../viewmodels/digits_viewmodel.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../widgets/button_widget.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/dotted_buttons.dart';
import '../widgets/shake_widget.dart';
import '../widgets/svg_icons.dart';

class DigitsScreen extends StatelessWidget {
  DigitsScreen({super.key});

  final DigitsViewModel digitsViewModel = Get.find();
  final TimerViewModel timerDigitsViewModel = Get.put(TimerViewModel());

  final int crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: deviceWidth / 13,
                    splashColor: AppColors.yellow.withAlpha(100),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.black,
                    ),
                  ),
                  _buildTimer(deviceSize),
                  Column(
                    children: [
                      IconButton(
                        iconSize: deviceWidth / 12,
                        splashColor: AppColors.yellow.withAlpha(100),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogWidget(
                                  steps: digitsViewModel.steps);
                            },
                          );
                          digitsViewModel.isRevealed = true;
                        },
                        icon: const Icon(
                          Icons.lightbulb,
                          color: AppColors.yellow,
                        ),
                      ),
                      Text(
                        'Reveal',
                        style: TextStyle(
                          fontSize: deviceWidth / 35,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight / 35,
              ),
              GetBuilder<DigitsViewModel>(
                builder: (digitsViewModel) {
                  return Text(
                    '${digitsViewModel.result}',
                    style: TextStyle(fontSize: deviceWidth / 6),
                  );
                },
              ),
              SizedBox(
                height: deviceHeight / 50,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: digitsViewModel.numbers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: deviceHeight / 30,
                  crossAxisSpacing: deviceWidth / 25,
                  mainAxisExtent: deviceWidth / 4,
                ),
                itemBuilder: (context, index) {
                  return GetBuilder<DigitsViewModel>(
                    init: DigitsViewModel(),
                    builder: (digitsViewModel) {
                      return AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: digitsViewModel.isNumVisible(index) ? 1 : 0,
                        child: _buildGridItems(index, deviceSize),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: deviceHeight / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: digitsViewModel.operations.keys
                    .map((e) => GetBuilder<DigitsViewModel>(
                          builder: (digitsViewModel) {
                            return _buildOperationWidget(e, deviceSize);
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight / 45,
          horizontal: deviceWidth / 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withAlpha(50),
                      offset: const Offset(1, 4),
                      blurRadius: 20)
                ],
              ),
              child: ButtonWidget(
                onTap: () => digitsViewModel.pop(),
                child: SvgIcons(
                  radius: deviceWidth / 7,
                  icon: SvgStrings.undo,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withAlpha(100),
                      offset: const Offset(2, 5),
                      blurRadius: 10)
                ],
              ),
              child: DottedButtons(
                onTap: () {
                  digitsViewModel.generateNext();
                  timerDigitsViewModel.restartTimer();
                },
                backgroundColor: AppColors.yellow,
                strokeWidth: 1,
                child: SvgIcons(
                  containerColor: Colors.transparent,
                  radius: deviceWidth / 5,
                  icon: SvgStrings.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer(Size size) {
    return Obx(
      () => Text(
        '${timerDigitsViewModel.minutes}:${timerDigitsViewModel.seconds}',
        style: TextStyle(
          fontSize: size.width / 30,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildGridItems(int index, Size size) {
    return ShakeWidget(
      shakeKey: digitsViewModel.shakeKey[index],
      child: DottedButtons(
        onTap: () => digitsViewModel.isOperationPossible(index),
        backgroundColor: digitsViewModel.isNumSelected(index)
            ? AppColors.yellow
            : Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(7),
          alignment: Alignment.center,
          child: digitsViewModel.isNumVisible(index)
              ? FittedBox(
                  child: Text(
                    '${digitsViewModel.numbers[index]}',
                    style: TextStyle(fontSize: size.width / 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildOperationWidget(String e, Size size) {
    return ButtonWidget(
      onTap: () {
        digitsViewModel.selectOperator(e);
      },
      child: SvgIcons(
        radius: size.width / 8,
        icon: digitsViewModel.operations[e]!,
        boxFit: BoxFit.scaleDown,
        iconColor: digitsViewModel.selectedOperation == e
            ? AppColors.black
            : AppColors.background,
      ),
    );
  }
}
