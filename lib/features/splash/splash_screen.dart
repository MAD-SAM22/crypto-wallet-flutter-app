import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/helpers/secure_storage_helper.dart';
import '../../theme/app_colors.dart';
import '../main_navigation.dart';
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
    _startAnimation();
    _navigateToNext();
  }

  void _startAnimation() {
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isAnimate = true;
        });
      }
    });
  }

  Future<void> _navigateToNext() async {
    final token = await SecureStorageHelper.getToken();
    
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingPage()),
        );
      }
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
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Icon(
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
