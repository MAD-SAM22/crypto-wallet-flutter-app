import 'package:crypto_project/core/networking/api_constants.dart';
import 'package:crypto_project/core/networking/api_error_handler.dart';
import 'package:crypto_project/core/networking/api_result.dart';
import 'package:crypto_project/core/networking/dio_factory.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = DioFactory.getDio();


  Future<ApiResult<dynamic>> getTrendingData({Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        ApiConstants.coingeckoBaseUrl + ApiConstants.trending,
        queryParameters: params,
      );
      return Success(response.data);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<dynamic>>> getCategoriesList() async {
    try {
      final response = await _dio.get(
        ApiConstants.coingeckoBaseUrl + ApiConstants.categories,
      );
      return Success(response.data as List<dynamic>);
    } catch (error) {
      return Failure(ApiErrorHandler.handle(error));
    }
  }


}
