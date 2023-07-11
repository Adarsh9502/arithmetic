import 'package:arithmetic/views/digits_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class LevelButtons extends StatelessWidget {
  final String levelIcon;
  final String title;
  final VoidCallback? onTap;
  const LevelButtons(
      {super.key,
      required this.levelIcon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DottedBorder(
      padding: EdgeInsets.zero,
      radius: const Radius.circular(25),
      borderType: BorderType.RRect,
      color: AppColors.black,
      strokeWidth: 1,
      strokeCap: StrokeCap.square,
      dashPattern: const [12, 7],
      child: ListTile(
        leading: SvgPicture.string(
          levelIcon,
          width: size.width / 15,
          colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          fit: BoxFit.scaleDown,
        ),
        tileColor: AppColors.yellow,
        splashColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onTap: () {
          onTap?.call();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DigitsScreen(),
          //   ),
          // );
          Get.to(const DigitsScreen());
        },
        title: Text(
          title,
          style: TextStyle(fontSize: size.height / 45),
        ),
        titleAlignment: ListTileTitleAlignment.center,
        textColor: AppColors.black,
      ),
    );
  }
}
