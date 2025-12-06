import 'package:flutter/material.dart';
import '../common/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _skillsAnimationController;
  late Animation<double> _skillsFadeAnimation;

  // Top technical skills to show
  final List<String> _topSkills = [
    'Flutter Development',
    'Dart Programming',
    'State Management',
    'API Development',
    'Go lang',
    'Backend Development',
    'Firebase',
    'CI/CD',
  ];

  @override
  void initState() {
    super.initState();
    _skillsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _skillsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _skillsAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Start animation after a delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _skillsAnimationController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _skillsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;
    final isMobile = screenWidth < 600;

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
                sectionTitle(context, 'About Me', icon: Icons.person_outline),
                const SizedBox(height: 20),
                Text(
                  'Get to know me better',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: isWide ? 16 : 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: isMobile ? 40 : 60),
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
                SizedBox(height: isMobile ? 40 : 60),
                // Technical Skills Section
                _buildSkillsSection(context, isWide, isMobile),
              ],
            ),
          ),
        ),
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
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.4)
                : Colors.grey.withValues(alpha: 0.3),
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
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.85),
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

  Widget _buildSkillsSection(BuildContext context, bool isWide, bool isMobile) {
    return FadeTransition(
      opacity: _skillsFadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _skillsAnimationController,
                curve: Curves.easeOutCubic,
              ),
            ),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.psychology_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: isMobile ? 20 : 24,
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 16),
                  Text(
                    'Technical Skills',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 20 : 24),
              Wrap(
                spacing: isMobile ? 12 : 16,
                runSpacing: isMobile ? 12 : 16,
                children: List.generate(
                  _topSkills.length,
                  (index) => _buildAnimatedSkillChip(
                    context,
                    _topSkills[index],
                    index,
                    isMobile,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSkillChip(
    BuildContext context,
    String skill,
    int index,
    bool isMobile,
  ) {
    // Create staggered animation based on index
    final delay = index * 0.1; // 100ms delay per item
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _skillsAnimationController,
        curve: Interval(
          delay.clamp(0.0, 0.8),
          (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOutBack,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Clamp animation value to prevent overflow (easeOutBack can overshoot)
        final clampedValue = animation.value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: clampedValue,
          child: Opacity(
            opacity: clampedValue,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 10 : 12,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.9),
                    Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
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
                  Text(
                    skill,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: isMobile ? 13 : 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
