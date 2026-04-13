import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class BalanceSection extends StatelessWidget {
  final double balance;
  final String currency;

  const BalanceSection({
    super.key,
    required this.balance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Available Balance',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          '${balance.toStringAsFixed(2)} ${currency.toUpperCase()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
