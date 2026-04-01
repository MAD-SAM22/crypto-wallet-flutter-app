import 'package:crypto_project/core/networking/api_error_handler.dart';

abstract class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorHandler errorHandler;
  const Failure(this.errorHandler);
}
