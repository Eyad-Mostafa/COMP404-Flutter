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

  /// Factory constructor for JSON deserialization from backend.
  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserModel(
      name: json['name'] as String? ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
    };
  }
}
