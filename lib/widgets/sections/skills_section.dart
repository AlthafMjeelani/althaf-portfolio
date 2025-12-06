import 'package:flutter/material.dart';
import '../common/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;
    final isMobile = screenWidth < 600;

    final skills = [
      'Flutter Development',
      'Dart Programming',
      'State Management (Provider, Bloc, Riverpod)',
      'Flutter Architecture (Clean, MVVM)',
      'Widget Development & Custom UI',
      'Flutter Animations & Transitions',
      'Platform Channels & Native Integration',
      'Flutter Performance Optimization',
      'Mobile App Development',
      'Android Native Development',
      'iOS App Development',
      'Cross-Platform Development',
      'API Development',
      'RESTful API Integration',
      'GraphQL Integration',
      'Go lang',
      'Backend Development',
      'SQL & NoSQL Databases',
      'Firebase Integration',
      'Authentication & Authorization',
      'Push Notifications',
      'Offline Data Sync',
      'Git & Version Control',
      'UI/UX Design (Figma)',
      'Docker & CI/CD',
      'Testing & Debugging',
    ];

    final languages = ['English', 'Malayalam', 'Hindi', 'Tamil'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isWide ? 60 : 24),
        vertical: isMobile ? 40 : 80,
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
                'Technical Skills',
                icon: Icons.code_outlined,
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
                child: Text(
                  'Technologies I work with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: isMobile ? 13 : (isWide ? 16 : 14),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 0),
                child: Wrap(
                  spacing: isMobile ? 12 : 20,
                  runSpacing: isMobile ? 12 : 20,
                  alignment: WrapAlignment.center,
                  children: skills
                      .map((s) => _buildSkillChip(s, isMobile))
                      .toList(),
                ),
              ),
              SizedBox(height: isMobile ? 40 : 60),
              // Languages Section
              sectionTitle(context, 'Languages', icon: Icons.language_outlined),
              SizedBox(height: isMobile ? 16 : 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 0),
                child: Wrap(
                  spacing: isMobile ? 12 : 16,
                  runSpacing: isMobile ? 12 : 16,
                  alignment: WrapAlignment.center,
                  children: languages
                      .map((lang) => _buildLanguageChip(lang, isMobile))
                      .toList(),
                ),
              ),
              SizedBox(height: isMobile ? 20 : 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, bool isMobile) {
    return Builder(
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.15),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: isMobile ? 6 : 8,
                height: isMobile ? 6 : 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Flexible(
                child: Text(
                  skill,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageChip(String language, bool isMobile) {
    return Builder(
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 10 : 12,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.translate,
                color: Theme.of(context).colorScheme.primary,
                size: isMobile ? 16 : 18,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                language,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
