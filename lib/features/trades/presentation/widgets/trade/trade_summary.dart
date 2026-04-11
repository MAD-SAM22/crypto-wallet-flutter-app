import 'package:flutter/material.dart';
import '../../../../../theme/app_colors.dart';

class TradeSummary extends StatelessWidget {
  final double payAmount;
  final double receiveAmount;
  final double fees;
  final String payCurrency;
  final String receiveCurrency;

  const TradeSummary({
    super.key,
    required this.payAmount,
    required this.receiveAmount,
    required this.fees,
    required this.payCurrency,
    required this.receiveCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.backgroundGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('You Pay', '${payAmount.toStringAsFixed(2)} $payCurrency'),
            const SizedBox(height: 12),
            _buildSummaryRow('You Receive', '${receiveAmount.toStringAsFixed(8)} $receiveCurrency'),
            const SizedBox(height: 12),
            _buildSummaryRow('Fees', '${fees.toStringAsFixed(2)} USDT'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
