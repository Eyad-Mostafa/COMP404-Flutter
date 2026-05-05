/// Model representing a user in the leaderboard.
///
/// Maps directly to the backend response objects:
/// `{ "name": "Ali", "score": 200 }`
class LeaderboardUserModel {
  final String name;
  final int score;

  const LeaderboardUserModel({
    required this.name,
    required this.score,
  });

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserModel(
      name: json['name'] ?? '',
      score: (json['score'] ?? 0) as int,
    );
  }
}