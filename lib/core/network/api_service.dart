import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://comp-404-backend.vercel.app/',
    ),
  );
}