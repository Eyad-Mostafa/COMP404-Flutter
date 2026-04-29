import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

class LeaderboardItem extends StatelessWidget {
  final LeaderboardUserModel user;
  final int rank;
  final bool isCurrentUser;
  final Animation<double> animation;

  const LeaderboardItem({
    super.key,
    required this.user,
    required this.rank,
    required this.isCurrentUser,
    required this.animation,
  });

  // ─── Medal helpers ───────────────────────────────────────────────

  bool get _isTopThree => rank <= 3;

  Color get _medalColor {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.transparent;
    }
  }

  IconData get _medalIcon {
    switch (rank) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.emoji_events;
      case 3:
        return Icons.emoji_events;
      default:
        return Icons.circle;
    }
  }

  // ─── Gradient for top‑3 cards ────────────────────────────────────

  LinearGradient? get _cardGradient {
    switch (rank) {
      case 1:
        return const LinearGradient(
          colors: [Color(0x33FFD700), Color(0x0DFFD700)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return const LinearGradient(
          colors: [Color(0x33C0C0C0), Color(0x0DC0C0C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 3:
        return const LinearGradient(
          colors: [Color(0x33CD7F32), Color(0x0DCD7F32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return null;
    }
  }

  // ─── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseCardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        gradient: _cardGradient,
        color: _cardGradient == null ? baseCardColor : null,
        borderRadius: BorderRadius.circular(16),
        border: isCurrentUser
            ? Border.all(color: const Color(0xFF6C63FF), width: 2)
            : _isTopThree
                ? Border.all(color: _medalColor.withAlpha(100), width: 1.5)
                : null,
        boxShadow: [
          if (isCurrentUser)
            BoxShadow(
              color: const Color(0xFF6C63FF).withAlpha(60),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 40 : 15),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // ── Rank badge ──
                _buildRankBadge(),
                const SizedBox(width: 14),

                // ── Avatar ──
                _buildAvatar(),
                const SizedBox(width: 14),

                // ── Name + subtitle ──
                Expanded(child: _buildNameSection(context)),

                // ── Score ──
                _buildScore(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Rank badge ──────────────────────────────────────────────────

  Widget _buildRankBadge() {
    if (_isTopThree) {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              _medalColor,
              _medalColor.withAlpha(180),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _medalColor.withAlpha(100),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(_medalIcon, color: Colors.white, size: 20),
      );
    }

    return SizedBox(
      width: 36,
      child: Text(
        '#$rank',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: isCurrentUser
              ? const Color(0xFF6C63FF)
              : Colors.grey.shade500,
        ),
      ),
    );
  }

  // ─── Avatar ──────────────────────────────────────────────────────

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isCurrentUser
              ? const Color(0xFF6C63FF)
              : _isTopThree
                  ? _medalColor
                  : Colors.transparent,
          width: 2.5,
        ),
        boxShadow: isCurrentUser
            ? [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withAlpha(40),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
    );
  }

  // ─── Name section ────────────────────────────────────────────────

  Widget _buildNameSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isCurrentUser ? FontWeight.w700 : FontWeight.w600,
            color: isCurrentUser
                ? const Color(0xFF6C63FF)
                : isDark
                    ? Colors.white
                    : const Color(0xFF1A1A2E),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        if (isCurrentUser)
          const Text(
            'You',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C63FF),
            ),
          ),
      ],
    );
  }

  // ─── Score ───────────────────────────────────────────────────────

  Widget _buildScore(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isCurrentUser
            ? const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
              )
            : _isTopThree
                ? LinearGradient(
                    colors: [
                      _medalColor.withAlpha(60),
                      _medalColor.withAlpha(30),
                    ],
                  )
                : null,
        color: isCurrentUser || _isTopThree
            ? null
            : const Color(0xFFF0F0F5),
      ),
      child: Text(
        '${user.score}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isCurrentUser
              ? Colors.white
              : _isTopThree
                  ? _medalColor.withAlpha(220)
                  : const Color(0xFF555570),
        ),
      ),
    );
  }
}
