import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit(this.repo) : super(AuthInitial());

  ///Register new user
  void register(
      String name,
      String email,
      String password,
      String confirmPassword,
      ) async {
    emit(AuthLoading());

    try {
      final res = await repo.register(
        name,
        email,
        password,
        confirmPassword,
      );

      emit(AuthSuccessMessage(res.message));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? "Email already exits";
        emit(AuthError(message));
      } else {
        emit(AuthError("Unexpected error"));
      }
    }
  }
///Login user
  void login(String email, String password) async {
    emit(AuthLoading());

    try {
      final res = await repo.login(email, password);
      emit(AuthSuccessMessage(res.message));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data['message'] ?? "No Register Email";
        emit(AuthError(message));
      } else {
        emit(AuthError("Unexpected error"));
      }
    }
  }

}