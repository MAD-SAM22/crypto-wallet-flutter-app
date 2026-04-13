import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../logic/home_cubit.dart';
import '../widgets/Coins_card.dart';
import '../widgets/category_card.dart';
import '../widgets/floating_action_card.dart';
import '../widgets/greeting_section.dart';
import '../widgets/section_header.dart';
import '../widgets/trending_coins_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getTrendingCoins(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const GreetingSection(),
              FloatingActionCard(),
              const SectionHeader("Categories"),
              const CategoriesSection(),
              const SectionHeader("Trending Coins"),
              const TrendingCoinsSection(),
              const SectionHeader("Favourite Coins"),
              const CoinCard(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
