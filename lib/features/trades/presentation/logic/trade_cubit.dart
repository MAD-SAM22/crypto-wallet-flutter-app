import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/trade_repo.dart';
import 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  final TradeRepo _tradeRepo;

  TradeCubit(this._tradeRepo) : super(const TradeInitial());

  void getCoins() async {
    emit(const TradeLoading());
    final result = await _tradeRepo.getCoinsList();
    
    result.when(
      success: (coins) {
        emit(TradeSuccess(coins: coins));
        if (coins.isNotEmpty) {
          getChartData(coins.first.id, '1'); // Default to 24H (1 day)
        }
      },
      failure: (error) {
        emit(TradeError(error: error.toString()));
      },
    );
  }

  void getChartData(String id, String days) async {
    final currentState = state;
    if (currentState is TradeSuccess) {
      // Clear old chart data and set loading to true
      emit(currentState.copyWith(
        chartData: null, 
        isChartLoading: true,
      ));
      
      final result = await _tradeRepo.getCoinMarketChart(id, days);
      
      result.when(
        success: (chartData) {
          emit(currentState.copyWith(
            chartData: chartData,
            isChartLoading: false,
          ));
        },
        failure: (error) {
          emit(currentState.copyWith(
            chartData: null,
            isChartLoading: false,
          ));
        },
      );
    }
  }
}
