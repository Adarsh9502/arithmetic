import 'package:arithmetic/widgets/success_dialog_widget.dart';
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
  const DigitsScreen({super.key});

  final int crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    final DigitsViewModel digitsViewModel = Get.find();
    final TimerViewModel timerViewModel = Get.put(TimerViewModel());
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
                    splashColor: AppColors.background,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    onPressed: () {
                      // Navigator.pop(context);
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.black,
                    ),
                  ),
                  _buildTimer(deviceSize, timerViewModel),
                  InkResponse(
                    onLongPress: () {
                      digitsViewModel.isRevealed = true;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWidget(
                            steps: digitsViewModel.resultSteps,
                            result: true,
                          );
                        },
                      );
                    },
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWidget(steps: digitsViewModel.userSteps);
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.stacked_line_chart,
                            color: AppColors.yellow,
                            size: deviceWidth / 12,
                          ),
                        ),
                        Text(
                          'Steps',
                          style: TextStyle(
                            fontSize: deviceWidth / 35,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
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
                        child: _buildGridItems(
                            context, index, digitsViewModel, timerViewModel),
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
                            return _buildOperationWidget(
                                e, deviceSize, digitsViewModel);
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
                  timerViewModel.restartTimer();
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

  Widget _buildTimer(Size size, TimerViewModel timerViewModel) {
    return Obx(
      () => Text(
        timerViewModel.getTime,
        style: TextStyle(
          fontSize: size.width / 30,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index,
      DigitsViewModel digitsViewModel, TimerViewModel timerViewModel) {
    final size = MediaQuery.of(context).size;
    return ShakeWidget(
      shakeKey: digitsViewModel.shakeKey[index],
      child: DottedButtons(
        onTap: () {
          digitsViewModel.isOperationPossible(index);
          if (digitsViewModel.isResultAchieved()) {
            showDialog(
              context: context,
              builder: (context) {
                return SuccessDialog(
                    timeElapsed: timerViewModel.getTime,
                    onTap: () {
                      digitsViewModel.generateNext();
                      timerViewModel.restartTimer();
                    });
              },
            );
          }
        },
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

  Widget _buildOperationWidget(
      String e, Size size, DigitsViewModel digitsViewModel) {
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
