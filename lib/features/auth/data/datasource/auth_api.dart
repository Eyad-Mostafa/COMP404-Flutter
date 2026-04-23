import '../../../../core/network/api_service.dart';
import '../models/message_response.dart';

class AuthApi {
  final ApiService apiService;

  AuthApi(this.apiService);

  Future<MessageResponse> register(
      String name,
      String email,
      String password,
      String confirmPassword,
      ) async {
    final response = await apiService.dio.post(
      'auth/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );

    return MessageResponse.fromJson(response.data);
  }

  Future<MessageResponse> login(
      String email,
      String password,
      ) async {
    final response = await apiService.dio.post(
      'auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    return MessageResponse.fromJson(response.data);
  }

}