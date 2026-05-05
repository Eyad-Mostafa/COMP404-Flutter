import 'package:flutter_test/flutter_test.dart';

import 'package:comp404_flutter/core/utils/validators.dart';
import 'package:comp404_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:comp404_flutter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:comp404_flutter/features/auth/data/datasource/auth_api.dart';
import 'package:comp404_flutter/core/network/api_service.dart';
import 'package:comp404_flutter/features/auth/presentation/cubit/auth_state.dart';

void main() {

  group("Auth Cubit Real API Tests", () {

    test("login success or error", () async {
      final cubit = AuthCubit(
        AuthRepositoryImpl(
          AuthApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          anyOf([
            isA<AuthSuccessMessage>(),
            isA<AuthError>(),
          ]),
        ]),
      );

      cubit.login("test@gmail.com", "12345678");
    });

    test("login wrong credentials", () async {
      final cubit = AuthCubit(
        AuthRepositoryImpl(
          AuthApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthError>(),
        ]),
      );

      cubit.login("wrong@email.com", "wrongpass");
    });

    test("register success or error", () async {
      final cubit = AuthCubit(
        AuthRepositoryImpl(
          AuthApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          anyOf([
            isA<AuthSuccessMessage>(),
            isA<AuthError>(),
          ]),
        ]),
      );

      cubit.register(
        "Ali",
        "newemail@test.com",
        "Aa123456",
        "Aa123456",
      );
    });

    test("register existing email", () async {
      final cubit = AuthCubit(
        AuthRepositoryImpl(
          AuthApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthError>(),
        ]),
      );

      cubit.register(
        "Ali",
        "test@gmail.com",
        "Aa123456",
        "Aa123456",
      );
    });

  });

}