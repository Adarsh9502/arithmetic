import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

class SvgIcons extends StatelessWidget {
  final double radius;
  final Color containerColor;
  final Color iconColor;
  final String icon;
  final BoxFit boxFit;
  const SvgIcons({
    super.key,
    required this.radius,
    this.containerColor = AppColors.yellow,
    this.iconColor = AppColors.background,
    required this.icon,
    this.boxFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(radius / 4),
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerColor,
      ),
      child: SvgPicture.string(
        icon,
        fit: boxFit,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}
