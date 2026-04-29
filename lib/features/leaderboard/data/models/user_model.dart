/// Model representing a user in the leaderboard.
///
/// This model is designed for easy backend integration —
/// simply replace the dummy data with API response parsing.
class LeaderboardUserModel {
  final String id;
  final String name;
  final String avatarUrl;
  final int score;

  const LeaderboardUserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.score,
  });

  /// Factory constructor for future JSON deserialization from backend.
  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'score': score,
    };
  }
}
