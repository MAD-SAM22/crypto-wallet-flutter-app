import 'package:crypto_project/core/networking/api_error_handler.dart';

abstract class ApiResult<T> {
  const ApiResult();

  get data => null;

  R when<R>({
    required R Function(T data) success,
    required R Function(ApiErrorHandler errorHandler) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return failure((this as Failure<T>).errorHandler);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorHandler errorHandler;
  const Failure(this.errorHandler);
}
