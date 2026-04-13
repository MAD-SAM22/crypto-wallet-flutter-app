import '../../../trades/data/models/coin.dart';
import '../../data/models/category_model.dart';

abstract class MarketsState {
  const MarketsState();
}

class MarketsInitial extends MarketsState {
  const MarketsInitial();
}

class MarketsLoading extends MarketsState {
  const MarketsLoading();
}

class MarketsSuccess extends MarketsState {
  final List<Coin> coins;
  final List<Coin> filteredCoins;
  final List<MarketCategory> categories;
  final String selectedCategoryId;
  final bool isCoinsLoading;

  const MarketsSuccess({
    required this.coins,
    required this.filteredCoins,
    required this.categories,
    this.selectedCategoryId = 'all',
    this.isCoinsLoading = false,
  });

  MarketsSuccess copyWith({
    List<Coin>? coins,
    List<Coin>? filteredCoins,
    List<MarketCategory>? categories,
    String? selectedCategoryId,
    bool? isCoinsLoading,
  }) {
    return MarketsSuccess(
      coins: coins ?? this.coins,
      filteredCoins: filteredCoins ?? this.filteredCoins,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isCoinsLoading: isCoinsLoading ?? this.isCoinsLoading,
    );
  }
}

class MarketsError extends MarketsState {
  final String error;
  const MarketsError({required this.error});
}
