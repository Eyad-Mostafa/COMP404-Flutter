import '../../../../core/network/api_service.dart';
import '../models/leaderboard_response.dart';

class LeaderboardApi {
  final ApiService apiService;

  LeaderboardApi(this.apiService);

  /// Calls GET /score/leaderboard to fetch the leaderboard data.
  Future<LeaderboardResponse> fetchLeaderboard({int count = 10}) async {
    final response = await apiService.dio.get(
      'score/leaderboard',
    );
    return LeaderboardResponse.fromJson(response.data);
  }
}