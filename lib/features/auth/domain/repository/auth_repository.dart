import '../../data/models/message_response.dart';

abstract class AuthRepository {
  Future<MessageResponse> register(
      String name,
      String email,
      String password,
      String confirmPassword,
      );


  Future<MessageResponse> login(
      String email,
      String password,
      );
}