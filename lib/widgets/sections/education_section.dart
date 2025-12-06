import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../hero/animated_background.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

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
                      'Education',
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Academic background',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: isWide ? 16 : 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 60),
                    isWide
                        ? Row(
                            children: [
                              for (int i = 0; i < education.length; i++)
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: i == 0 ? 16 : 0,
                                      left: i == 1 ? 16 : 0,
                                    ),
                                    child: _buildEducationCard(
                                      context,
                                      education: education[i],
                                      index: i,
                                      isWide: isWide,
                                    ),
                                  ),
                                ),
                            ],
                          )
                        : Column(
                            children: [
                              for (int i = 0; i < education.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: _buildEducationCard(
                                    context,
                                    education: education[i],
                                    index: i,
                                    isWide: isWide,
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

  Widget _buildEducationCard(
    BuildContext context, {
    required Map<String, String> education,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              index == 0 ? Icons.school_outlined : Icons.menu_book_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            education['degree']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: isWide ? 22 : 20,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              education['school']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF00D9FF),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              education['period']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
