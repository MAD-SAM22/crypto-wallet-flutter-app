import 'package:crypto_project/core/networking/api_result.dart';
import '../../data/models/coin.dart';

abstract class TradeRepo {
  Future<ApiResult<List<Coin>>> getCoinsList();
  Future<ApiResult<List<List<double>>>> getCoinMarketChart(String id, String days);
}
