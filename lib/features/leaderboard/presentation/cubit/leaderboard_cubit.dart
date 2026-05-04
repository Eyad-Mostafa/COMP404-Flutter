import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/leaderboard_repository.dart';
import 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepository repo;

  LeaderboardCubit(this.repo) : super(LeaderboardInitial());

  /// Fetch leaderboard from the backend.
  /// The data is displayed exactly as received — no frontend sorting.
  void fetchLeaderboard({int count = 10}) async {
    emit(LeaderboardLoading());
 
    try {
      final res = await repo.fetchLeaderboard(count: count);
      emit(LeaderboardSuccess(res.data));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }
}
