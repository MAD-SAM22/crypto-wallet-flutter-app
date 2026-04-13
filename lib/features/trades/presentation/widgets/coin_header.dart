import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';
import '../../data/models/coin.dart';

class CoinHeader extends StatelessWidget {
  final Coin coin;

  const CoinHeader({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.backgroundGrey,
          backgroundImage: NetworkImage(coin.image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coin.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '${coin.symbol.toUpperCase()}  #${coin.marketCapRank}',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${coin.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${isPositive ? '+' : ''}${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(
                color: isPositive ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
