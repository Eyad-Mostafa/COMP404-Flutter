import 'user_model.dart';

/// Maps the full backend response:
/// ```json
/// {
///   "message": "Leaderboard Retrieved Successfully",
///   "data": [ { "name": "Ali", "score": 200 }, ... ]
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
    final rawList = json['data'] as List<dynamic>?;

    return LeaderboardResponse(
      message: json['message'] as String? ?? '',
      data: rawList
              ?.map((e) =>
                  LeaderboardUserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
