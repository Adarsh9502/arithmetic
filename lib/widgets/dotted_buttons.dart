import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../utils/app_colors.dart';
import '../widgets/button_widget.dart';

class DottedButtons extends StatelessWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Widget child;
  final double strokeWidth;
  const DottedButtons(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      this.strokeWidth = 1.3,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: DottedBorder(
          padding: EdgeInsets.zero,
          borderType: BorderType.Circle,
          color: AppColors.black,
          strokeWidth: strokeWidth,
          strokeCap: StrokeCap.square,
          dashPattern: const [12, 7],
          child: child,
        ),
      ),
    );
  }
}
