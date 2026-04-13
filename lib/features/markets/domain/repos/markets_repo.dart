import '../../../../core/networking/api_result.dart';
import '../../../trades/data/models/coin.dart';
import '../../data/models/category_model.dart';

abstract class MarketsRepo {
  Future<ApiResult<List<Coin>>> getMarketsCoins({String? categoryId});
  Future<ApiResult<List<MarketCategory>>> getCategories();
}
