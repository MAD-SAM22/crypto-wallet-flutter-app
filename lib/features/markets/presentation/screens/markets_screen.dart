import 'package:crypto_project/core/di/dependency_injection.dart';
import 'package:crypto_project/features/markets/presentation/logic/markets_cubit.dart';
import 'package:crypto_project/features/markets/presentation/logic/markets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../widgets/category_chips.dart';
import '../widgets/market_coin_item.dart';
import '../widgets/market_search_bar.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MarketsCubit>()..getMarkets(),
      child: const MarketsBody(),
    );
  }
}

class MarketsBody extends StatelessWidget {
  const MarketsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Markets',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const MarketSearchBar(),
          const SizedBox(height: 8),
          const CategoryChips(),
          Expanded(
            child: BlocBuilder<MarketsCubit, MarketsState>(
              builder: (context, state) {
                if (state is MarketsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MarketsError) {
                  return Center(child: Text(state.error));
                } else if (state is MarketsSuccess) {
                  return Stack(
                    children: [
                      ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.filteredCoins.length,
                        separatorBuilder: (context, index) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          return MarketCoinItem(coin: state.filteredCoins[index]);
                        },
                      ),
                      if (state.isCoinsLoading)
                        Container(
                          color: Colors.white.withOpacity(0.5),
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
