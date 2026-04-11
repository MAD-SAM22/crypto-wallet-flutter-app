import '../../../../core/networking/api_result.dart';
import '../../data/models/category_model.dart';
import '../entities/trending_coin.dart';

abstract class HomeRepo {
  Future<ApiResult<List<TrendingCoin>>> getTrendingCoins();
  Future<ApiResult<List<TrendingCoin>>> getTopCoins();
  Future<ApiResult<List<CategoryModel>>> getCategories();
}
