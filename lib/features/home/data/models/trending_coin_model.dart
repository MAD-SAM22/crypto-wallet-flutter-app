import '../../domain/entities/trending_coin.dart';

class TrendingCoinModel extends TrendingCoin {
  TrendingCoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.price,
    required super.priceChangePercentage24h,
  });

  factory TrendingCoinModel.fromJson(Map<String, dynamic> json) {
    final item = json['item'];
    return TrendingCoinModel(
      id: item['id'] ?? '',
      symbol: item['symbol'] ?? '',
      name: item['name'] ?? '',
      image: item['large'] ?? '',
      price: (item['data']['price'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h: (item['data']['price_change_percentage_24h']?['usd'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
