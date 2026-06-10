import 'package:flutter_riverpod/legacy.dart';
import 'package:techyspot_todo/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:techyspot_todo/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:techyspot_todo/features/authentication/domain/usecase/login_usecase.dart';
import 'package:techyspot_todo/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:techyspot_todo/features/authentication/presentation/providers/auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final datasource = AuthRemoteDatasource();
  final repository = AuthRepositoryImpl(datasource);
  final loginUseCase = LoginUseCase(repository);
  final logoutUseCase = LogoutUseCase(repository);

  return AuthNotifier(loginUseCase, logoutUseCase);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthNotifier(this._loginUseCase, this._logoutUseCase)
    : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _loginUseCase(email: email, password: password);
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _logoutUseCase();
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
