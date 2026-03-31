import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        color: _isAnimate ? AppColors.background : AppColors.primary,
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            scale: _isAnimate ? 1.0 : 2.5,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.currency_bitcoin,
                size: 40,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
