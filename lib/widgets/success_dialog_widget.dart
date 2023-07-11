import 'package:arithmetic/utils/svg_strings.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class SuccessDialog extends StatelessWidget {
  final String timeElapsed;
  final VoidCallback? onTap;
  const SuccessDialog({super.key, required this.timeElapsed, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height / 30),
                  child: SvgPicture.string(
                    SvgStrings.happy,
                    width: size.width / 5,
                  ),
                ),
                Text(
                  'Hurray!!',
                  style: TextStyle(
                    fontSize: size.width / 20,
                  ),
                ),
                SizedBox(
                  height: size.height / 25,
                ),
                const FittedBox(
                  child: Text('You completed the puzzle in'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    timeElapsed,
                    style: TextStyle(
                        color: AppColors.yellow, fontSize: size.width / 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / 35, horizontal: size.width / 35),
                  child: GestureDetector(
                    onTap: () {
                      onTap?.call();
                      Get.back();
                    },
                    child: DottedBorder(
                        padding: EdgeInsets.zero,
                        radius: const Radius.circular(35),
                        borderType: BorderType.RRect,
                        color: AppColors.black,
                        strokeWidth: 1.5,
                        strokeCap: StrokeCap.square,
                        dashPattern: const [12, 7],
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 15,
                              vertical: size.height / 70),
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.string(
                                SvgStrings.next,
                                width: size.width / 15,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.black, BlendMode.srcIn),
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                width: size.width / 15,
                              ),
                              Text(
                                'Next Puzzle',
                                style: TextStyle(
                                  fontSize: size.width / 20,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: AppColors.yellow,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.background,
              size: size.width / 15,
            ),
          )
        ],
      ),
    );
  }
}
