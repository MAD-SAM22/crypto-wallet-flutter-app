import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xffff5f00),
      child: Icon(
        Icons.currency_bitcoin,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }
}
