import 'package:flutter/material.dart';
import '../common/section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;
    final isMobile = screenWidth < 600;

    final education = [
      {
        'degree': 'Bachelor of Computer Applications (BCA)',
        'school':
            'MET Arts and Science College, Nadapuram — Calicut University',
        'period': 'Jun 2019 – Mar 2022',
      },
      {
        'degree': 'Higher Secondary Education',
        'school': 'GHSS Avala Kuttoth, Calicut',
        'period': 'Jun 2017 – Mar 2019',
      },
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
                sectionTitle(context, 'Education', icon: Icons.school_outlined),
                SizedBox(height: isMobile ? 24 : 40),
                Column(
                  children: [
                    for (int i = 0; i < education.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: i < education.length - 1
                              ? (isMobile ? 24 : 32)
                              : 0,
                        ),
                        child: _buildEducationCard(
                          context,
                          education: education[i],
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

  Widget _buildEducationCard(
    BuildContext context, {
    required Map<String, String> education,
    required int index,
    required bool isWide,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
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
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with icon and period
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: isMobile ? 56 : 64,
                height: isMobile ? 56 : 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  index == 0 ? Icons.school_outlined : Icons.menu_book_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: isMobile ? 28 : 32,
                ),
              ),
              SizedBox(width: isMobile ? 16 : 20),
              // Period badge and content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 14,
                        vertical: isMobile ? 6 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15),
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
                            Icons.calendar_today_outlined,
                            size: isMobile ? 12 : 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(width: isMobile ? 6 : 8),
                          Text(
                            education['period']!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: isMobile ? 11 : 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 20),
                    // Degree title
                    Text(
                      education['degree']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: isMobile ? 18 : (isWide ? 22 : 20),
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    // School name
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            size: isMobile ? 16 : 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 12),
                        Expanded(
                          child: Text(
                            education['school']!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: isMobile ? 14 : 16,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
