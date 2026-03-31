import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double radius;
  final double iconSize;

  const AppLogo({
    Key? key,
    this.radius = 40,
    this.iconSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary,
      child: Icon(
        Icons.currency_bitcoin,
        size: iconSize,
        color: AppColors.textWhite,
      ),
    );
  }
}
