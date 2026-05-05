import 'user_model.dart';

/// Maps the full backend response:
/// ```json
/// {
///   "0": { "name": "Ali", "score": 200 },
///   "1": { "name": "Nada", "score": 100 },
///   "message": "Leaderboard Retrieved Successfully"
/// }
/// ```
class LeaderboardResponse {
  final String message;
  final List<LeaderboardUserModel> data;

  const LeaderboardResponse({
    required this.message,
    required this.data,
  });

  factory LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    final users = <LeaderboardUserModel>[];

    // The backend returns entries at numeric keys ("0", "1", "2", …)
    // alongside "message" (and optionally "success").
    // We iterate sorted numeric keys to preserve the backend ordering.
    final numericKeys = json.keys
        .where((k) => int.tryParse(k) != null)
        .toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    for (final key in numericKeys) {
      final entry = json[key];
      if (entry is Map<String, dynamic>) {
        users.add(LeaderboardUserModel.fromJson(entry));
      }
    }

    return LeaderboardResponse(
      message: json['message'] as String? ?? '',
      data: users,
    );
  }
}