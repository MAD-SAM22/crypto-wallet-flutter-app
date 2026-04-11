import 'package:flutter/material.dart';
import '../../../../../theme/app_colors.dart';
import '../../../data/models/trade_enums.dart';

class BuySellToggle extends StatelessWidget {
  final TradeType selectedType;
  final ValueChanged<TradeType> onChanged;

  const BuySellToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              label: 'BUY',
              isSelected: selectedType == TradeType.buy,
              activeColor: AppColors.success,
              onTap: () => onChanged(TradeType.buy),
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              label: 'SELL',
              isSelected: selectedType == TradeType.sell,
              activeColor: AppColors.error,
              onTap: () => onChanged(TradeType.sell),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
