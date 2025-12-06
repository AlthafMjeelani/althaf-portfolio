import 'package:flutter/material.dart';
import '../common/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;
    final isMobile = screenWidth < 600;

    final experiences = [
      {
        'role': 'Flutter Developer – Lead',
        'company': 'Texol World, Calicut, Kerala',
        'period': 'Jan 2024 – Present',
        'desc':
            'Leading app development, deployment & release pipelines. Implemented CI/CD with GitHub Actions and collaborated on cloud synchronization.',
      },
      {
        'role': 'Flutter Developer',
        'company': 'BigWelt Infotech Pvt. Ltd., Bangalore',
        'period': 'Dec 2022 – Dec 2023',
        'desc':
            'Built cross-platform apps with optimized state management. Ensured seamless collaboration with backend & UI/UX teams.',
      },
      {
        'role': 'Flutter Developer Intern',
        'company': 'Brototype, Calicut, Kerala',
        'period': 'May 2022 – Dec 2022',
        'desc':
            'Delivered client projects end-to-end and learned state management, performance optimization, and deployment.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isWide ? 60 : 24),
        vertical: isMobile ? 40 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sectionTitle(
                context,
                'Experience',
                icon: Icons.business_center_outlined,
              ),
              SizedBox(height: isMobile ? 24 : 40),
              // Timeline with experience cards
              _buildTimeline(context, experiences, isWide, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(
    BuildContext context,
    List<Map<String, String>> experiences,
    bool isWide,
    bool isMobile,
  ) {
    final timelineLeft = isMobile ? 12.0 : (isWide ? 40.0 : 20.0);

    return Stack(
      children: [
        // Vertical timeline line
        if (!isMobile)
          Positioned(
            left: timelineLeft,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
        // Timeline items
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < experiences.length; i++)
              _buildTimelineItem(
                context,
                experience: experiences[i],
                index: i,
                isWide: isWide,
                isMobile: isMobile,
                isLast: i == experiences.length - 1,
                timelineLeft: timelineLeft,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required Map<String, String> experience,
    required int index,
    required bool isWide,
    required bool isMobile,
    required bool isLast,
    required double timelineLeft,
  }) {
    final nodeSize = isMobile ? 12.0 : 16.0;
    final leftPadding = isMobile ? 0.0 : (timelineLeft + nodeSize + 24);

    return Padding(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : (isMobile ? 24 : 40),
        left: leftPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline node (circle) - only show if not mobile
          if (!isMobile)
            Container(
              margin: EdgeInsets.only(right: 16, top: 4),
              width: nodeSize,
              height: nodeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          // Experience card
          Expanded(
            child: _buildExperienceCard(
              context,
              experience: experience,
              index: index,
              isWide: isWide,
              isMobile: isMobile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required Map<String, String> experience,
    required int index,
    required bool isWide,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 12,
              vertical: isMobile ? 5 : 6,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              experience['period']!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: isMobile ? 11 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          // Role title
          Text(
            experience['role']!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 16 : (isWide ? 20 : 18),
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 8),
          // Company name
          Row(
            children: [
              Icon(
                Icons.business_outlined,
                size: isMobile ? 14 : 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: isMobile ? 4 : 6),
              Flexible(
                child: Text(
                  experience['company']!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
          // Description
          Text(
            experience['desc']!,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
              fontSize: isMobile ? 13 : (isWide ? 15 : 14),
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
