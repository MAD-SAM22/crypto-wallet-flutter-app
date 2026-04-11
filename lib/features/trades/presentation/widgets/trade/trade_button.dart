import 'package:flutter/material.dart';
import '../../../../../theme/app_colors.dart';
import '../../../data/models/trade_enums.dart';

class TradeButton extends StatelessWidget {
  final TradeType tradeType;
  final String coinSymbol;
  final VoidCallback onPressed;

  const TradeButton({
    super.key,
    required this.tradeType,
    required this.coinSymbol,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isBuy = tradeType == TradeType.buy;
    final color = isBuy ? AppColors.success : AppColors.error;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          '${isBuy ? 'Buy' : 'Sell'} ${coinSymbol.toUpperCase()}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
