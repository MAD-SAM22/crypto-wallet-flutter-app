import '../../../../core/networking/api_result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<UserEntity>> login(String email, String password);
  Future<ApiResult<UserEntity>> signup(String email, String password, String name);
}
