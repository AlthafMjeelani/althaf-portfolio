import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../hero/animated_background.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

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
                      'Experience',
                      icon: Icons.business_center_outlined,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'My professional journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: isWide ? 16 : 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline line
                        if (isWide) ...[
                          SizedBox(
                            width: 4,
                            child: Column(
                              children: [
                                Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF00D9FF),
                                        Color(0xFF0099CC),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                for (int i = 0; i < experiences.length - 1; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 60,
                                    ),
                                    width: 4,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF00D9FF,
                                      ).withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                        // Experience cards
                        Expanded(
                          child: Column(
                            children: [
                              for (int i = 0; i < experiences.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: isWide ? 60 : 24,
                                  ),
                                  child: _buildExperienceCard(
                                    context,
                                    experience: experiences[i],
                                    index: i,
                                    isWide: isWide,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildExperienceCard(
    BuildContext context, {
    required Map<String, String> experience,
    required int index,
    required bool isWide,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1F2E).withValues(alpha: 0.85),
            const Color(0xFF0F1419).withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
            blurRadius: 25,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide) ...[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        experience['role']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: isWide ? 22 : 20,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    if (!isWide)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    experience['company']!,
                    style: const TextStyle(
                      color: Color(0xFF00D9FF),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  experience['period']!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  experience['desc']!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: isWide ? 15 : 14,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
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
