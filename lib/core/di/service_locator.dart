import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../network/api_service.dart';
import '../../features/auth/data/datasource/auth_api.dart';
import '../../features/auth/data/repository_impl/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

import '../../features/leaderboard/data/datasource/leaderboard_api.dart';
import '../../features/leaderboard/data/repository_impl/leaderboard_repository_impl.dart';
import '../../features/leaderboard/domain/repository/leaderboard_repository.dart';
import '../../features/leaderboard/presentation/cubit/leaderboard_cubit.dart';

final sl = GetIt.instance;

void setup() {
  // Core
  sl.registerSingleton<ApiService>(ApiService());

  // ─── Auth ────────────────────────────────────────────────────────
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

  // ─── Leaderboard ─────────────────────────────────────────────────
  // Data sources
  sl.registerLazySingleton<LeaderboardApi>(
        () => LeaderboardApi(sl<ApiService>()),
  );

  // Repository
  sl.registerLazySingleton<LeaderboardRepository>(
        () => LeaderboardRepositoryImpl(sl<LeaderboardApi>()),
  );

  // Cubit
  sl.registerFactory<LeaderboardCubit>(
        () => LeaderboardCubit(sl<LeaderboardRepository>()),
  );
}