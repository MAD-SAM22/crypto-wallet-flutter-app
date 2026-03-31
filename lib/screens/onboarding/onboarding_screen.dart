import 'package:flutter/material.dart';
import '../auth/auth_screen.dart';

class StageContent {
  final String imagePath;
  final String titlePart1;
  final String titlePart2;
  final String description;

  StageContent({
    required this.imagePath,
    required this.titlePart1,
    required this.titlePart2,
    required this.description,
  });
}

StageContent returnStageContent(int stage) {
  switch (stage) {
    case 0:
      return StageContent(
          imagePath: "assets/images/anytime_anywhere.png",
          titlePart1: "Trade anytime  ",
          titlePart2: "anywhere",
          description:
              "Access global crypto markets 24/7 from anywhere in the world with our secure mobile platform.");
    case 1:
      return StageContent(
        imagePath: "assets/images/crypto_wallet.png",
        titlePart1: "Manage Your ",
        titlePart2: "Crypto Wallet",
        description:
            "Buy, Store, Send Exchange & Earn Crypto. Track your expenses.",
      );
    case 2:
      return StageContent(
        imagePath: "assets/images/save_invest.png",
        titlePart1: "Save and invest ",
        titlePart2: "at the same time",
        description:
            "Grow your wealth with smart crypto investments while automatically saving for your future goals.",
      );
    case 3:
      return StageContent(
        imagePath: "assets/images/transact.png",
        titlePart1: "Transact fast ",
        titlePart2: "and easy",
        description:
            "Send and receive crypto instantly with low fees and lightning-fast transaction processing.",
      );
    default:
      return StageContent(
        imagePath: "",
        titlePart1: "",
        titlePart2: "",
        description: "",
      );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int stage = 0;

  @override
  Widget build(BuildContext context) {
    final content = returnStageContent(stage);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  },
                  child: Text("Skip", style: TextStyle(color: Colors.grey[700])),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF8C42),
                      Color(0xFFFF5F00),
                    ],
                  ),
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      content.imagePath,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Spacer(),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                  children: [
                    TextSpan(
                      text: content.titlePart1,
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: content.titlePart2,
                      style: const TextStyle(color: Color(0xffff5f00)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                content.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontFamily: "Montserrat",
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        stage = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: stage == index ? 48 : 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: stage == index
                            ? const Color(0xffff5f00)
                            : Colors.grey[400],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff5f00),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (stage < 3) {
                      setState(() {
                        stage++;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthScreen()),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
