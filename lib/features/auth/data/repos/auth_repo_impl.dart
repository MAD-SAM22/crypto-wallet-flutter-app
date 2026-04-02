import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;

  AuthRepoImpl(this._apiService);

  @override
  Future<ApiResult<UserEntity>> login(String email, String password) async {
    try {
      final data = await SecureStorageHelper.getUserData();
      if (data['email'] == email && data['password'] == password) {
        // Save a dummy token to indicate the user is logged in
        await SecureStorageHelper.saveToken("dummy_token_123");
        
        return Success(UserEntity(
          id: '1',
          email: email,
          name: data['fullname'],
          phone: data['phoneno'],
        ));
      }
      return Failure(ApiErrorHandler.handle("Invalid email or password"));
    } catch (e) {
      return Failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<UserEntity>> signup(String email, String password, String name, String phone) async {
    try {
      await SecureStorageHelper.saveUserData(email, password, name, phone);
      // Save a dummy token to indicate the user is logged in after signup
      await SecureStorageHelper.saveToken("dummy_token_123");

      return Success(UserEntity(id: '1', email: email, name: name, phone: phone));
    } catch (e) {
      return Failure(ApiErrorHandler.handle(e));
    }
  }
}
