import 'package:crypto_project/features/home/domain/entities/trending_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../../domain/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  void getTrendingCoins() async {
    emit(HomeLoading());
    final result = await _homeRepo.getTrendingCoins();
    result.when(
      success: (coins) => emit(HomeSuccess(coins)),
      failure: (errorHandler) => emit(HomeError(errorHandler.apiErrorModel.message ?? 'Unknown Error')),
    );
  }
  void getCategories() async {
    emit(HomeLoading());
    final result = await _homeRepo.getCategories();
    result.when(
        success: (categories) => emit(CategorySuccess(categories.cast<TrendingCoin>())),
        failure: (errorHandler) => emit(HomeError(errorHandler.apiErrorModel.message ?? 'Unknown Error')),
    );
  }

}
