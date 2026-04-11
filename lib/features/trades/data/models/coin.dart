class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double priceChange24h;
  final int marketRank;
  final String imageUrl;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.priceChange24h,
    required this.marketRank,
    required this.imageUrl,
  });
}
