import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Added SingleTickerProviderStateMixin to power the loading dots animation
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _startAnimation = false;
  bool _showContent = false; // Controls the fade-in of text and dots

  late AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    // Setup the repeating animation for the loading dots
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true); // Reverses back and forth for a pulsing effect

    _startSequence();
  }

  @override
  void dispose() {
    // Always dispose of animation controllers to prevent memory leaks
    _dotController.dispose();
    super.dispose();
  }

  Future<void> _startSequence() async {
    // 1. Trigger the background color and logo scale animation
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _startAnimation = true;
      });
    }

    // 2. Wait for the logo to shrink, then fade in the text and dots
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) {
      setState(() {
        _showContent = true;
      });
    }

    // 3. Wait a few seconds for the user to see the splash screen, then navigate
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  OnboardingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  // A helper widget to create the animated pulsing dots
  Widget _buildAnimatedDot(int index) {
    return AnimatedBuilder(
      animation: _dotController,
      builder: (context, child) {
        // Create a slight delay based on the index so they don't all pulse at once
        double offset = index * 0.3;
        double dotValue = (_dotController.value - offset).abs();

        // Calculate dynamic scale and opacity
        double scale = (1.0 - dotValue).clamp(0.6, 1.0);
        double opacity = (1.0 - dotValue).clamp(0.2, 1.0);

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: Color(0xFFFF5F00), // Matching orange
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOutCubic,
        color: _startAnimation ? Colors.white : const Color(0xFFFF5F00),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- THE LOGO ---
              AnimatedScale(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutBack,
                scale: _startAnimation ? 1.0 : 3.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF5F00),
                    boxShadow: _startAnimation
                        ? [
                      BoxShadow(
                        color: const Color(0xFFFF5F00).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ]
                        : [],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.currency_bitcoin,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- APP NAME ---
              // AnimatedOpacity smoothly reveals the text without shifting the layout
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _showContent ? 1.0 : 0.0,
                child: const Text(
                  "CryptoFlow", // Replace with your actual app name
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A), // Dark grey/black for contrast
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- LOADING DOTS ---
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _showContent ? 1.0 : 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAnimatedDot(0),
                    _buildAnimatedDot(1),
                    _buildAnimatedDot(2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}