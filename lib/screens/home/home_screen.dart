import 'package:crypto_project/screens/home/components/category_card.dart';
import 'package:crypto_project/screens/home/components/floating_action_card.dart';
import 'package:crypto_project/screens/home/components/greeting_section.dart';
import 'package:flutter/material.dart';

import 'components/Coins_card.dart';
import 'components/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GreetingSection(),
            FloatingActionCard(),
            const SectionHeader("Categories"),
            const CategoriesSection(),
            const SectionHeader("Recent Coins"),
            const CoinCard(),
            const SectionHeader("Top Coins"),
            const CoinCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
