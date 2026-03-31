import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _coinCard(
              "BTC/BUSD",
              "40,059.83",
              "+0.81%",
              "https://cryptologos.cc/logos/bitcoin-btc-logo.png", // Example URL
              true,
              [
                const FlSpot(0, 2), const FlSpot(2, 1.5), const FlSpot(4, 3),
                const FlSpot(6, 2.2), const FlSpot(8, 3.5), const FlSpot(10, 2.8)
              ]
          ),
          _coinCard(
              "ETH/BUSD",
              "2,450.12",
              "+1.15%",
              "https://cryptologos.cc/logos/ethereum-eth-logo.png",
              true,
              [
                const FlSpot(0, 1), const FlSpot(2, 2.5), const FlSpot(4, 2),
                const FlSpot(6, 3.8), const FlSpot(8, 3), const FlSpot(10, 4.2)
              ]
          ),
        ],
      ),
    );
  }

  Widget _coinCard(String pair, String price, String change, String imageUrl,
      bool isUp, List<FlSpot> spots) {
    final statusColor = isUp ? const Color(0xFF56D6A1) : const Color(0xFFFF4D4D);

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Price and Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price Text (Top Left)
              Text(
                price,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              // Floating Icon (Top Right)
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.circle, color: Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Subtitle: Pair and Percentage
          Row(
            children: [
              Text(
                pair,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF1B1D1F),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                change,
                style: TextStyle(
                  fontSize: 14,
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 50,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.4,
                    color: statusColor,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          statusColor.withOpacity(0.2),
                          statusColor.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}