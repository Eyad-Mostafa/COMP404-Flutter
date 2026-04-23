import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../network/api_service.dart';
import '../../features/auth/data/datasource/auth_api.dart';
import '../../features/auth/data/repository_impl/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

final sl = GetIt.instance;

void setup() {
  // Core
  sl.registerSingleton<ApiService>(ApiService());

  // Data sources
  sl.registerLazySingleton<AuthApi>(
        () => AuthApi(sl<ApiService>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl<AuthApi>()),
  );


  //Cubit
  sl.registerFactory<AuthCubit>(()=>AuthCubit(sl<AuthRepository>()));
}