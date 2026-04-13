import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../trades/data/models/coin.dart';
import '../../data/models/category_model.dart';
import '../../domain/repos/markets_repo.dart';

class MarketsRepoImpl implements MarketsRepo {
  @override
  Future<ApiResult<List<Coin>>> getMarketsCoins({String? categoryId}) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        '${ApiConstants.coingeckoBaseUrl}${ApiConstants.coinsList}',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 100,
          'page': 1,
          'sparkline': false,
          if (categoryId != null && categoryId != 'all') 'category': categoryId,
        },
      );
      
      final List<dynamic> data = response.data;
      final coins = data.map((json) => Coin.fromJson(json)).toList();
      return Success(coins);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<MarketCategory>>> getCategories() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        '${ApiConstants.coingeckoBaseUrl}${ApiConstants.categories}',
      );
      
      final List<dynamic> data = response.data;
      final categories = data.map((json) => MarketCategory.fromJson(json)).toList();
      return Success(categories);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }
}
