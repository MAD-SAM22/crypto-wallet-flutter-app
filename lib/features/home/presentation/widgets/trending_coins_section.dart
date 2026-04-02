import 'dart:math';
import 'package:crypto_project/core/networking/api_result.dart';
import 'package:crypto_project/core/networking/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrendingCoinsSection extends StatefulWidget {
  const TrendingCoinsSection({super.key});

  @override
  State<TrendingCoinsSection> createState() => _TrendingCoinsSectionState();
}

class _TrendingCoinsSectionState extends State<TrendingCoinsSection> {
  final ApiService _apiService = ApiService();
  late Future<ApiResult<dynamic>> _trendingFuture;

  @override
  void initState() {
    super.initState();
    _trendingFuture = _apiService.getTrendingData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<dynamic>>(
      future: _trendingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final result = snapshot.data;

        if (result is Failure) {
          return Center(
            child: Text(
              "Error: ${result.errorHandler.apiErrorModel.message}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (result is Success) {
          final List coins = result.data['coins'] ?? [];
          return SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index]['item'];
                final double change = coin['data']['price_change_percentage_24h']['usd'] ?? 0.0;
                
                // Generate unique spots for each coin based on its performance and identity
                List<FlSpot> dynamicSpots = _generateTrendSpots(change, coin['name'] ?? "");

                return _coinCard(
                  "${coin['symbol']}/USD",
                  "\$${coin['data']['price'].toStringAsFixed(4)}",
                  "${change.toStringAsFixed(2)}%",
                  coin['large'],
                  change >= 0,
                  dynamicSpots,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }


  List<FlSpot> _generateTrendSpots(double change, String coinName) {
    final random = Random(coinName.hashCode);
    final List<FlSpot> spots = [];
    const int count = 8;
    
    double currentY = 100.0; // Start point
    spots.add(FlSpot(0, currentY));
    
    // Calculate how much the trend should move per step to reach the target change
    // We add some randomness to make it look like a real market graph
    for (int i = 1; i < count; i++) {
      double fluctuation = (random.nextDouble() * 20) - 10; // Random noise -10 to 10
      double trendImpact = change * 2; // Direct impact of the percentage change
      
      currentY += (trendImpact / count) + fluctuation;
      spots.add(FlSpot(i.toDouble() * 2, currentY));
    }
    
    return spots;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  price,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                height: 34,
                width: 34,
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.circle, color: Colors.orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
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
            height: 40,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: statusColor,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          statusColor.withOpacity(0.15),
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
