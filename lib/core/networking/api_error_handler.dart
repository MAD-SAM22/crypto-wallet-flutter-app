import 'package:dio/dio.dart';

enum DataSource {
  success(200, "Success"),
  noContent(201, "No Content"),
  badRequest(400, "Bad Request"),
  unauthorized(401, "Unauthorized"),
  forbidden(403, "Forbidden"),
  notFound(404, "Not Found"),
  internalServerError(500, "Internal Server Error"),
  connectTimeout(-1, "Connect Timeout"),
  cancel(-2, "Request Cancelled"),
  receiveTimeout(-3, "Receive Timeout"),
  sendTimeout(-4, "Send Timeout"),
  cacheError(-5, "Cache Error"),
  noInternetConnection(-6, "No Internet Connection"),
  defaultError(-7, "Something went wrong");

  final int code;
  final String message;
  const DataSource(this.code, this.message);

  // Directly returns the model
  ApiErrorModel get failure => ApiErrorModel(code: code, message: message);
}

class ApiErrorHandler implements Exception {
  late final ApiErrorModel apiErrorModel;

  ApiErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = DataSource.defaultError.failure;
    }
  }

  ApiErrorModel _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout: return DataSource.connectTimeout.failure;
      case DioExceptionType.sendTimeout:       return DataSource.sendTimeout.failure;
      case DioExceptionType.receiveTimeout:    return DataSource.receiveTimeout.failure;
      case DioExceptionType.cancel:            return DataSource.cancel.failure;
      case DioExceptionType.connectionError:   return DataSource.noInternetConnection.failure;
      case DioExceptionType.badResponse:
        return error.response?.data != null
            ? ApiErrorModel.fromJson(error.response!.data)
            : DataSource.defaultError.failure;
      default:
        return DataSource.defaultError.failure;
    }
  }
}

class ApiErrorModel {
  final String? message;
  final int? code;

  ApiErrorModel({this.message, this.code});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    message: json['message'] as String?,
    code: json['code'] as int?,
  );
}