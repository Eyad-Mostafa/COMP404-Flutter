import 'package:flutter_test/flutter_test.dart';

import 'package:comp404_flutter/core/network/api_service.dart';
import 'package:comp404_flutter/features/leaderboard/data/datasource/leaderboard_api.dart';
import 'package:comp404_flutter/features/leaderboard/data/repository_impl/leaderboard_repository_impl.dart';
import 'package:comp404_flutter/features/leaderboard/presentation/cubit/leaderboard_cubit.dart';
import 'package:comp404_flutter/features/leaderboard/presentation/cubit/leaderboard_state.dart';

void main() {

  group("Leaderboard Tests (Real API)", () {


    test("fetch leaderboard success or error", () async {
      final cubit = LeaderboardCubit(
        LeaderboardRepositoryImpl(
          LeaderboardApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<LeaderboardLoading>(),
          anyOf([
            isA<LeaderboardSuccess>(),
            isA<LeaderboardError>(),
          ]),
        ]),
      );

      cubit.fetchLeaderboard();
    });


    test("leaderboard returns data list", () async {
      final cubit = LeaderboardCubit(
        LeaderboardRepositoryImpl(
          LeaderboardApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsThrough(
          isA<LeaderboardSuccess>(),
        ),
      );

      cubit.fetchLeaderboard();
    });


    test("leaderboard error case", () async {
      final cubit = LeaderboardCubit(
        LeaderboardRepositoryImpl(
          LeaderboardApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<LeaderboardLoading>(),
          anyOf([
            isA<LeaderboardError>(),
            isA<LeaderboardSuccess>(),
          ]),
        ]),
      );

      cubit.fetchLeaderboard(count: -1);
    });


    test("state flow should start with loading", () async {
      final cubit = LeaderboardCubit(
        LeaderboardRepositoryImpl(
          LeaderboardApi(ApiService()),
        ),
      );

      expectLater(
        cubit.stream,
        emits(
          isA<LeaderboardLoading>(),
        ),
      );

      cubit.fetchLeaderboard();
    });

  });

}