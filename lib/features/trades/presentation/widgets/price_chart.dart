import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class PriceChart extends StatefulWidget {
  final List<List<double>>? chartData;
  final bool isLoading;
  final Function(String) onFilterChanged;

  const PriceChart({
    super.key,
    this.chartData,
    this.isLoading = false,
    required this.onFilterChanged,
  });

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {
  String selectedFilter = '24H';
  final Map<String, String> filterValues = {
    '1H': '0.04', // ~1 hour in days
    '24H': '1',
    '7D': '7',
    '1M': '30',
    '1Y': '365',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.chartData == null || widget.chartData!.isEmpty
                  ? const Center(child: Text("No chart data available"))
                  : Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20, left: 10, bottom: 10),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: widget.chartData!.map((point) {
                                return FlSpot(point[0], point[1]);
                              }).toList(),
                              isCurved: true,
                              color: AppColors.primary,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: AppColors.primary.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: filterValues.keys.map((filter) {
            final isSelected = selectedFilter == filter;
            return GestureDetector(
              onTap: () {
                setState(() => selectedFilter = filter);
                widget.onFilterChanged(filterValues[filter]!);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
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
