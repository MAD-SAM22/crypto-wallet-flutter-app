import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/models/trade_enums.dart';

class OrderTypeSelector extends StatelessWidget {
  final OrderType selectedOrderType;
  final ValueChanged<OrderType> onChanged;

  const OrderTypeSelector({
    super.key,
    required this.selectedOrderType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderType>(
          value: selectedOrderType,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onChanged: (OrderType? newValue) {
            if (newValue != null) onChanged(newValue);
          },
          items: OrderType.values.map((OrderType type) {
            return DropdownMenuItem<OrderType>(
              value: type,
              child: Text(
                '${type.name[0].toUpperCase()}${type.name.substring(1)} Order',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
