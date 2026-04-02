import '../../../../core/networking/api_result.dart';
import '../entities/trending_coin.dart';

abstract class HomeRepo {
  Future<ApiResult<List<TrendingCoin>>> getTrendingCoins();
}
