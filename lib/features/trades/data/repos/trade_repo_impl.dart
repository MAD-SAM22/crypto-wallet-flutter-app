import 'package:crypto_project/core/networking/api_constants.dart';
import 'package:crypto_project/core/networking/api_error_handler.dart';
import 'package:crypto_project/core/networking/api_result.dart';
import 'package:crypto_project/core/networking/api_service.dart';
import 'package:crypto_project/core/networking/dio_factory.dart';
import 'package:crypto_project/features/trades/data/models/coin.dart';
import 'package:crypto_project/features/trades/domain/repos/trade_repo.dart';

class TradeRepoImpl implements TradeRepo {
  final ApiService _apiService;

  TradeRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<Coin>>> getCoinsList() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        '${ApiConstants.coingeckoBaseUrl}${ApiConstants.coinsList}',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 50,
          'page': 1,
          'sparkline': false,
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
  Future<ApiResult<List<List<double>>>> getCoinMarketChart(String id, String days) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        '${ApiConstants.coingeckoBaseUrl}coins/$id/market_chart',
        queryParameters: {
          'vs_currency': 'usd',
          'days': days,
        },
      );
      
      final List<dynamic> prices = response.data['prices'];
      final List<List<double>> chartData = prices.map((point) {
        return [
          (point[0] as num).toDouble(),
          (point[1] as num).toDouble(),
        ];
      }).toList();
      
      return Success(chartData);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }
}
