import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../../domain/repos/markets_repo.dart';
import 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  final MarketsRepo _marketsRepo;

  MarketsCubit(this._marketsRepo) : super(const MarketsInitial());

  void getMarkets() async {
    emit(const MarketsLoading());
    
    final categoriesResult = await _marketsRepo.getCategories();
    final coinsResult = await _marketsRepo.getMarketsCoins();

    categoriesResult.when(
      success: (categories) {
        coinsResult.when(
          success: (coins) {
            emit(MarketsSuccess(
              coins: coins,
              filteredCoins: coins,
              categories: categories,
            ));
          },
          failure: (error) {
            emit(MarketsError(error: error.apiErrorModel.message ?? 'Error fetching coins'));
          },
        );
      },
      failure: (error) {
        emit(MarketsError(error: error.apiErrorModel.message ?? 'Error fetching categories'));
      },
    );
  }

  void filterByCategory(String categoryId) async {
    final currentState = state;
    if (currentState is MarketsSuccess) {
      // 1. Emit loading state with the selected ID to highlight the chip immediately
      emit(currentState.copyWith(isCoinsLoading: true, selectedCategoryId: categoryId));
      
      final result = await _marketsRepo.getMarketsCoins(categoryId: categoryId);
      
      // 2. We need to check the state again because it might have changed during the async call
      final updatedState = state;
      if (updatedState is MarketsSuccess) {
        result.when(
          success: (coins) {
            emit(updatedState.copyWith(
              coins: coins,
              filteredCoins: coins,
              isCoinsLoading: false,
              selectedCategoryId: categoryId, // Ensure it stays selected
            ));
          },
          failure: (error) {
            emit(updatedState.copyWith(isCoinsLoading: false));
          },
        );
      }
    }
  }

  void searchCoins(String query) {
    final currentState = state;
    if (currentState is MarketsSuccess) {
      if (query.isEmpty) {
        emit(currentState.copyWith(filteredCoins: currentState.coins));
      } else {
        final filtered = currentState.coins.where((coin) {
          return coin.name.toLowerCase().contains(query.toLowerCase()) ||
                 coin.symbol.toLowerCase().contains(query.toLowerCase());
        }).toList();
        emit(currentState.copyWith(filteredCoins: filtered));
      }
    }
  }
}
