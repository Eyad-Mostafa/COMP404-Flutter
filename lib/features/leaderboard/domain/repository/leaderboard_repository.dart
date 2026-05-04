import '../../data/models/leaderboard_response.dart';

abstract class LeaderboardRepository {
  Future<LeaderboardResponse> fetchLeaderboard({int count = 10});
}
