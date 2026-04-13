import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class AmountInputSection extends StatelessWidget {
  final String symbol;
  final ValueChanged<String> onAmountChanged;

  const AmountInputSection({
    super.key,
    required this.symbol,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amount',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onAmountChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: '0.00',
            suffixText: symbol.toUpperCase(),
            filled: true,
            fillColor: AppColors.backgroundGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['25%', '50%', '75%', 'MAX'].map((percent) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Implement percentage logic
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    percent,
                    style: const TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
