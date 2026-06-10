import 'package:techyspot_todo/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:techyspot_todo/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource remoteDS;

  AuthRepositoryImpl(this.remoteDS);

  @override
  Future<void> login({required String email, required String password}) async {
    await remoteDS.login(email: email, password: password);
  }
  @override
  Future<void> logout() async {
    await remoteDS.logout();
  }
}
