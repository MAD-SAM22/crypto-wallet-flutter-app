import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../trades/data/models/coin.dart';

class MarketCoinItem extends StatefulWidget {
  final Coin coin;

  const MarketCoinItem({super.key, required this.coin});

  @override
  State<MarketCoinItem> createState() => _MarketCoinItemState();
}

class _MarketCoinItemState extends State<MarketCoinItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.coin.priceChangePercentage24h >= 0;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.coin.image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.coin.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                widget.coin.symbol.toUpperCase(),
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${widget.coin.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${isPositive ? '+' : ''}${widget.coin.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(
                color: isPositive ? AppColors.success : AppColors.error,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : AppColors.textSecondary,
            size: 20,
          ),
        ),
      ],
    );
  }
}
