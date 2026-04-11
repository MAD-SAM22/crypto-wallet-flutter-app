import 'package:crypto_project/features/home/data/models/category_model.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../domain/entities/Coin_category.dart';
import '../../domain/entities/trending_coin.dart';
import '../../domain/repos/home_repo.dart';
import '../models/trending_coin_model.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;

  HomeRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<TrendingCoin>>> getTrendingCoins() async {
    final result = await _apiService.getTrendingData();
    if (result is Success) {
      final List coinsJson = result.data['coins'] ?? [];
      final List<TrendingCoin> coins =
          coinsJson.map((json) => TrendingCoinModel.fromJson(json)).toList();
      return Success(coins);
    } else {
      return Failure((result as Failure).errorHandler);
    }
  }

  Future<ApiResult<List<TrendingCoin>>> getTopCoins() async {
    final result = await _apiService.getTrendingData();

    if (result is Success) {
      final List coinsJson = result.data['coins'] ?? [];
      final List<TrendingCoin> coins =
      coinsJson.map((json) => TrendingCoinModel.fromJson(json)).toList();
      return Success(coins);
    } else {
      return Failure((result as Failure).errorHandler);
    }
  }



  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    // 1. Call the service
    final result = await _apiService.getCategoriesList();

    if (result is Success) {
      // 2. Safely cast the data as a List
      final List jsonData = result.data ?? [];

      // 3. Map to your Category model (ensure this model matches the API fields)
      final List<CategoryModel> categories =
      jsonData.map((json) => CategoryModel.fromJson(json)).toList();

      return Success(categories);
    } else {
      // 4. Properly cast the failure to pass the error handler back
      return Failure((result as Failure).errorHandler);
    }
  }
}
