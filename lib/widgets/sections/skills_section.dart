import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../hero/animated_background.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

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
      constraints: const BoxConstraints(minHeight: 600),
      child: Stack(
        children: [
          // Animated background (same as home)
          const AnimatedBackground(),

          // Content - Centered
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sectionTitle(
                      context,
                      'Technical Skills',
                      icon: Icons.code_outlined,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Technologies I work with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: isWide ? 16 : 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: skills.map((s) => _buildSkillChip(s)).toList(),
                    ),
                    const SizedBox(height: 60),
                    // Languages Section
                    sectionTitle(
                      context,
                      'Languages',
                      icon: Icons.language_outlined,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: languages
                          .map((lang) => _buildLanguageChip(lang))
                          .toList(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1F2E).withValues(alpha: 0.9),
            const Color(0xFF0F1419).withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withValues(alpha: 0.6),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            skill,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00D9FF).withValues(alpha: 0.15),
            const Color(0xFF0099CC).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00D9FF).withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D9FF).withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.translate, color: const Color(0xFF00D9FF), size: 18),
          const SizedBox(width: 8),
          Text(
            language,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
