import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../hero/animated_background.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

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
                      'About Me',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Get to know me better',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: isWide ? 16 : 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Two column layout for wide screens
                    isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.person_outline,
                                  title: 'Who I Am',
                                  content:
                                      "I'm Althaf, a 23-year-old software engineer from Kozhikode, Kerala. "
                                      "I'm all about crafting cool tech and turning ideas into real, impactful solutions. "
                                      "Always learning, always building—let's create something awesome!",
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.code_outlined,
                                  title: 'My Journey',
                                  content:
                                      "I fell in love with Flutter in May 2022 when I built my first app (E-commerce). "
                                      "Since then, I've developed over 15 Flutter apps and gained 3+ years of experience building offline-first, API-integrated, high-performance apps.",
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildInfoCard(
                                context,
                                icon: Icons.person_outline,
                                title: 'Who I Am',
                                content:
                                    "I'm Althaf, a 23-year-old software engineer from Kozhikode, Kerala. "
                                    "I'm all about crafting cool tech and turning ideas into real, impactful solutions. "
                                    "Always learning, always building—let's create something awesome!",
                              ),
                              const SizedBox(height: 24),
                              _buildInfoCard(
                                context,
                                icon: Icons.code_outlined,
                                title: 'My Journey',
                                content:
                                    "I fell in love with Flutter in May 2022 when I built my first app (E-commerce). "
                                    "Since then, I've developed over 15 Flutter apps and gained 3+ years of experience building offline-first, API-integrated, high-performance apps.",
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
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
            color: const Color(0xFF00D9FF).withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF00D9FF), size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
