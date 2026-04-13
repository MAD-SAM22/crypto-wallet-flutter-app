import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class CoinCard extends StatefulWidget {
  const CoinCard({super.key});

  @override
  State<CoinCard> createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  final ApiService _apiService = ApiService();
  late Future<ApiResult<dynamic>> _favoriteFuture;

  @override
  void initState() {
    super.initState();
    // For now, we'll fetch the same data but represent them as "Favorites"
    // In a real app, this would fetch from a local database or specific user favorites endpoint
    _favoriteFuture = _apiService.getTrendingData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<dynamic>>(
      future: _favoriteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 190,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final result = snapshot.data;

        if (result is Success) {
          final List coins = result.data['coins'] ?? [];
          // Take a few items to represent "Favorites"
          final favoriteItems = coins.take(3).toList();

          if (favoriteItems.isEmpty) {
            return const SizedBox(
              height: 190,
              child: Center(child: Text("No favorites yet")),
            );
          }

          return SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final coin = favoriteItems[index]['item'];
                final double change = coin['data']['price_change_percentage_24h']['usd'] ?? 0.0;
                
                return _coinCard(
                  "${coin['symbol']}/USD",
                  "\$${coin['data']['price'].toStringAsFixed(2)}",
                  "${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%",
                  coin['large'],
                  change >= 0,
                  _generateTrendSpots(change, coin['name'] ?? ""),
                );
              },
            ),
          );
        }

        return const SizedBox(
          height: 190,
          child: Center(child: Text("Unable to load favorites")),
        );
      },
    );
  }

  List<FlSpot> _generateTrendSpots(double change, String coinName) {
    final random = Random(coinName.hashCode);
    final List<FlSpot> spots = [];
    double currentY = 100.0;
    spots.add(FlSpot(0, currentY));
    
    for (int i = 1; i < 8; i++) {
      double fluctuation = (random.nextDouble() * 20) - 10;
      currentY += (change * 2 / 8) + fluctuation;
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
              Text(
                price,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                height: 34,
                width: 34,
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.circle, color: Colors.orange),
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
