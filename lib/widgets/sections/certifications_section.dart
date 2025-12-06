import 'package:flutter/material.dart';
import '../common/section_title.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;
    final isMobile = screenWidth < 600;

    final items = [
      '🥇 Employee of the Month — 4× in one year',
      'Recognized for outstanding Flutter project delivery and innovation.',
    ];

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : (isWide ? 60 : 24),
              vertical: isMobile ? 40 : 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sectionTitle(
                  context,
                  'Achievements',
                  icon: Icons.emoji_events_outlined,
                ),
                SizedBox(height: isMobile ? 24 : 40),
                Column(
                  children: [
                    for (int i = 0; i < items.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: i < items.length - 1
                              ? (isMobile ? 20 : 24)
                              : 0,
                        ),
                        child: _buildAchievementCard(
                          context,
                          text: items[i],
                          index: i,
                          isWide: isWide,
                          isMobile: isMobile,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: isMobile ? 20 : 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context, {
    required String text,
    required int index,
    required bool isWide,
    required bool isMobile,
  }) {
    final isTitle = index == 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.4)
                : Colors.grey.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trophy icon
          Container(
            width: isMobile ? 60 : 72,
            height: isMobile ? 60 : 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              isTitle ? Icons.emoji_events : Icons.star_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: isMobile ? 32 : 36,
            ),
          ),
          SizedBox(width: isMobile ? 20 : 24),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isTitle)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 14,
                      vertical: isMobile ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2),
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.workspace_premium,
                          size: isMobile ? 16 : 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: isMobile ? 6 : 8),
                        Text(
                          'Achievement',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: isMobile ? 12 : 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isTitle) SizedBox(height: isMobile ? 16 : 20),
                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: isTitle
                        ? (isMobile ? 17 : (isWide ? 19 : 18))
                        : (isMobile ? 15 : 16),
                    height: 1.6,
                    fontWeight: isTitle ? FontWeight.w800 : FontWeight.w500,
                    letterSpacing: isTitle ? -0.2 : 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
