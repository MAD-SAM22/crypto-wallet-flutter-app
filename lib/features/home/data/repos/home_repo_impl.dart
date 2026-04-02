import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
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
}
