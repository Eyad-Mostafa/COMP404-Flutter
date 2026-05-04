import '../../domain/repository/leaderboard_repository.dart';
import '../datasource/leaderboard_api.dart';
import '../models/leaderboard_response.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardApi api;

  LeaderboardRepositoryImpl(this.api);

  @override
  Future<LeaderboardResponse> fetchLeaderboard({int count = 10}) {
    return api.fetchLeaderboard(count: count);
  }
}
