import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../data/models/user_model.dart';
import '../widgets/leaderboard_item.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  late final List<LeaderboardUserModel> _sortedUsers;
  late final ScrollController _scrollController;
  final List<AnimationController> _animControllers = [];
  final List<Animation<double>> _animations = [];

  int _currentUserIndex = -1;

  // ─── Lifecycle ───────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    // Sort descending by score.
    _sortedUsers = List.of(dummyLeaderboardUsers)
      ..sort((a, b) => b.score.compareTo(a.score));

    _scrollController = ScrollController();

    // Find the current user index.
    _currentUserIndex =
        _sortedUsers.indexWhere((u) => u.id == currentUserId);

    // Create staggered animations for each item.
    for (int i = 0; i < _sortedUsers.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      _animControllers.add(controller);
      _animations.add(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ));
    }

    // Trigger staggered entrance.
    _playStaggeredAnimation();
  }

  Future<void> _playStaggeredAnimation() async {
    for (int i = 0; i < _animControllers.length; i++) {
      // Wait a tiny stagger between items.
      await Future.delayed(const Duration(milliseconds: 60));
      if (!mounted) return;
      _animControllers[i].forward();
    }

    // After all items animate in, scroll to current user if needed.
    if (_currentUserIndex > 4) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      _scrollToCurrentUser();
    }
  }

  void _scrollToCurrentUser() {
    if (_currentUserIndex < 0) return;

    // Approximate item height (card ≈ 76 + vertical margin 10).
    const itemExtent = 86.0;
    // Header occupies ~280 px.
    const headerOffset = 280.0;

    final targetOffset = headerOffset +
        (_currentUserIndex * itemExtent) -
        (MediaQuery.of(context).size.height / 2 - itemExtent);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (final c in _animControllers) {
      c.dispose();
    }
    super.dispose();
  }

  // ─── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──
          _buildSliverAppBar(),

          // ── Top‑3 podium header ──
          SliverToBoxAdapter(child: _buildPodiumHeader()),

          // ── List ──
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = _sortedUsers[index];
                  final rank = index + 1;

                  return LeaderboardItem(
                    user: user,
                    rank: rank,
                    isCurrentUser: user.id == currentUserId,
                    animation: _animations[index],
                  );
                },
                childCount: _sortedUsers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sliver App Bar ──────────────────────────────────────────────

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 60,
      backgroundColor: const Color(0xFF0F0F1E),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white70, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: const Text(
        'Leaderboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        if (_currentUserIndex >= 0)
          IconButton(
            icon: const Icon(Icons.my_location_rounded,
                color: Color(0xFF6C63FF), size: 22),
            tooltip: 'Go to my rank',
            onPressed: _scrollToCurrentUser,
          ),
      ],
    );
  }

  // ─── Podium Header (Top 3) ──────────────────────────────────────

  Widget _buildPodiumHeader() {
    if (_sortedUsers.length < 3) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── 2nd place ──
          _buildPodiumUser(
            user: _sortedUsers[1],
            rank: 2,
            height: 90,
            avatarRadius: 28,
            medalColor: const Color(0xFFC0C0C0),
          ),
          const SizedBox(width: 12),

          // ── 1st place (tallest) ──
          _buildPodiumUser(
            user: _sortedUsers[0],
            rank: 1,
            height: 120,
            avatarRadius: 36,
            medalColor: const Color(0xFFFFD700),
          ),
          const SizedBox(width: 12),

          // ── 3rd place ──
          _buildPodiumUser(
            user: _sortedUsers[2],
            rank: 3,
            height: 75,
            avatarRadius: 26,
            medalColor: const Color(0xFFCD7F32),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumUser({
    required LeaderboardUserModel user,
    required int rank,
    required double height,
    required double avatarRadius,
    required Color medalColor,
  }) {
    final isMe = user.id == currentUserId;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Crown for #1 ──
        if (rank == 1)
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Icon(Icons.auto_awesome, color: Color(0xFFFFD700), size: 24),
          ),

        // ── Avatar stack ──
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: medalColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: medalColor.withAlpha(80),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                  if (isMe)
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withAlpha(60),
                      blurRadius: 18,
                      spreadRadius: 4,
                    ),
                ],
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
            ),
            // Medal chip
            Positioned(
              bottom: -8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: medalColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: medalColor.withAlpha(120),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ── Name ──
        SizedBox(
          width: 80,
          child: Text(
            user.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isMe ? const Color(0xFF6C63FF) : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),

        // ── Score ──
        Text(
          '${user.score}',
          style: TextStyle(
            color: medalColor,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),

        // ── Pedestal bar ──
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                medalColor.withAlpha(60),
                medalColor.withAlpha(20),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            border: Border(
              top: BorderSide(color: medalColor.withAlpha(120), width: 2),
              left: BorderSide(color: medalColor.withAlpha(50), width: 1),
              right: BorderSide(color: medalColor.withAlpha(50), width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
