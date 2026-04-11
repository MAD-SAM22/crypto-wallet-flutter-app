import '../../data/models/coin.dart';

abstract class TradeState {
  const TradeState();
}

class TradeInitial extends TradeState {
  const TradeInitial();
}

class TradeLoading extends TradeState {
  const TradeLoading();
}

class TradeSuccess extends TradeState {
  final List<Coin> coins;
  final List<List<double>>? chartData;
  final bool isChartLoading;
  
  const TradeSuccess({
    required this.coins,
    this.chartData,
    this.isChartLoading = false,
  });

  TradeSuccess copyWith({
    List<Coin>? coins,
    List<List<double>>? chartData,
    bool? isChartLoading,
  }) {
    return TradeSuccess(
      coins: coins ?? this.coins,
      chartData: chartData ?? this.chartData,
      isChartLoading: isChartLoading ?? this.isChartLoading,
    );
  }
}

class TradeError extends TradeState {
  final String error;
  const TradeError({required this.error});
}
