import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_api.dart';
import '../models/message_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl(this.api);

  @override
  Future<MessageResponse> register(
      String name,
      String email,
      String password,
      String confirmPassword,
      ) {
    return api.register(name, email, password, confirmPassword);
  }

  @override
  Future<MessageResponse> login(
      String email,
      String password,
      ) {
    return api.login(email, password);
  }
}