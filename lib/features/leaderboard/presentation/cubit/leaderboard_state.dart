import '../../data/models/user_model.dart';

abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardSuccess extends LeaderboardState {
  final List<LeaderboardUserModel> users;
  LeaderboardSuccess(this.users);
}

class LeaderboardError extends LeaderboardState {
  final String error;
  LeaderboardError(this.error);
}
