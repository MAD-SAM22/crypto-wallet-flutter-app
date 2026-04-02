import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/auth_repo.dart';

class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState { final String message; AuthError(this.message); }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepo.login(email, password);
    result.when(
      success: (user) => emit(AuthSuccess()),
      failure: (error) => emit(AuthError(error.apiErrorModel.message ?? 'Login failed')),
    );
  }

  Future<void> signup(String email, String password, String name, String phone) async {
    emit(AuthLoading());
    final result = await _authRepo.signup(email, password, name, phone);
    result.when(
      success: (user) => emit(AuthSuccess()),
      failure: (error) => emit(AuthError(error.apiErrorModel.message ?? 'Signup failed')),
    );
  }
}
