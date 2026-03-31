import 'package:crypto_project/components/bottom_navigation_bar.dart';
import 'package:crypto_project/screens/home/home_screen.dart';
import 'package:crypto_project/screens/main_navigation.dart';
import 'package:crypto_project/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Wallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor:  AppColors.primary,
        ),
        useMaterial3: true,
      ),
       home:    const SplashScreen(),
    );
  }
}
