import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Althaf M | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          surfaceBright: Color(0xFF0F1115),
          primary: Color(0xFF7DD3FC),
          secondary: Color(0xFF151923),
          surface: Color(0xFF151923),
          onSurface: Color(0xFFE9EDF1),
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HeroHeader(),
                SizedBox(height: 48),
                AnimatedReveal(child: AboutSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: ProjectsSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: ExperienceSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: EducationSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: CertificationsSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: SkillsSection()),
                SizedBox(height: 48),
                AnimatedReveal(child: ContactSection()),
                SizedBox(height: 64),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- MODERN HERO HEADER ----------------
class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(24),
      child: Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isWide
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isWide ? 3 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Althaf M',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const _TypewriterText(
                  phrases: [
                    'Flutter & Dart Expert',
                    'Cross-Platform App Developer',
                    'State Management Pro',
                    'UI/UX Enthusiast',
                    'Clean Architecture Advocate',
                    'Performance Optimizer',
                    'API Integration Specialist',
                    'Firebase & Backend Developer',
                    'Open Source Contributor',
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'I craft clean, fast, and reliable apps with Flutter — focused on delightful UX, performance, and offline-first reliability.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _HeroPill(text: 'Flutter'),
                    _HeroPill(text: 'Dart'),
                    _HeroPill(text: 'SQLite Sync'),
                    _HeroPill(text: 'API Integration'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20, width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutBack,
              scale: 1.0,
              child: Image.asset(
                'assets/images/profile_image.png',
                width: isWide ? 220 : 160,
                height: isWide ? 220 : 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final String text;
  const _HeroPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: const Color(0xFF0F1115),
      labelStyle: const TextStyle(color: Colors.white),
      side: const BorderSide(color: Color(0xFF2A3242)),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  final List<String> phrases;
  const _TypewriterText({required this.phrases});

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _typingAnimation;
  int _currentPhraseIndex = 0;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initTypewriter();
  }

  void _initTypewriter() {
    if (widget.phrases.isEmpty) return;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // Total duration for typing
    );

    _startTyping();
  }

  void _startTyping() {
    if (_isDisposed || !mounted) return;

    final phrase = widget.phrases[_currentPhraseIndex];
    _typingAnimation =
        IntTween(begin: 0, end: phrase.length).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // Move to next phrase after a delay
            Future.delayed(const Duration(seconds: 2), () {
              if (!mounted || _isDisposed) return;
              setState(() {
                _currentPhraseIndex =
                    (_currentPhraseIndex + 1) % widget.phrases.length;
                _startTyping();
              });
            });
          }
        });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.phrases.isEmpty) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _typingAnimation,
      builder: (context, child) {
        final phrase =
            widget.phrases[_currentPhraseIndex % widget.phrases.length];
        final text = phrase.substring(0, _typingAnimation.value);

        return Text(
          text,
          style: const TextStyle(
            color: Color(0xFF7DD3FC),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        );
      },
    );
  }
}

// ---------------- ABOUT ----------------
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(context, '🌈 About Me'),
        const SizedBox(height: 15),
        Text(
          "I’m Althaf, a 23-year-old software engineer from Kozhikode, Kerala. "
          "I’m all about crafting cool tech and turning ideas into real, impactful solutions. "
          "Always learning, always building—let’s create something awesome!\n\n"
          "I fell in love with Flutter in May 2022 when I built my first app (E-commerce). "
          "Since then, I’ve developed over 15 Flutter apps and gained 3+ years of experience building offline-first, API-integrated, high-performance apps.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

// ---------------- PROJECTS ----------------
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'Vanforces — Van Sales & Inventory App',
        tech: 'Flutter · SQLite · REST API',
        period: 'Jan 2024 – Present',
        points: [
          'Offline-capable app with two-way sync using SQLite.',
          'Google Maps routing for delivery optimization.',
          'Complete inventory management with live stock tracking.',
          'Real-time location tracking optimized for battery.',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.vanforces.salesman.app',
      ),
      Project(
        title: 'DHG Car Wash — Car Wash Management Suite',
        tech: 'Flutter · REST API · Apple Pay · Telr Payment',
        period: 'Jun 2025 – Aug 2025',
        points: [
          'Three connected apps (Customer, Shop, Operator).',
          'Integrated Apple Pay, Telr & Wallet system.',
          'Commission management & booking tracking modules.',
        ],
        playStoreUrl: '',
      ),
      Project(
        title: 'Speak Order — Voice-Based Ordering Platform',
        tech: 'Flutter · REST API',
        period: 'Dec 2024 – Mar 2025',
        points: [
          'AI voice-ordering supporting multiple languages.',
          'Auto-translation and real-time cross-language chat.',
          'Geo-based business discovery and integrated payments.',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.stocksnap',
      ),
      Project(
        title: 'Taskforces — ERP & Business Management System',
        tech: 'Flutter · REST API · Cloud Sync',
        period: 'Apr 2024 – Present',
        points: [
          'ERP mobile suite: inventory, sales, invoicing, orders, collections.',
          'Real-time data sync for offline operations.',
          'Role-based access, multi-warehouse tracking, analytics dashboards.',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.taskforces',
      ),
      Project(
        title: 'WorkForceTime — Attendance & HR Management System',
        tech: 'Flutter · REST API',
        period: 'Mar 2024 – Present',
        points: [
          'QR & GPS-based attendance, shift management, leave tracking.',
          'Real-time payroll and productivity reports.',
          'Clean architecture with efficient background sync.',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.taskforces',
      ),
      Project(
        title: 'AGSKart — Recharge & Bill Payment App',
        tech: 'Flutter · REST API · UPI',
        period: 'Jun 2023 – Dec 2023',
        points: [
          'Multi-platform recharge & bill payment app.',
          'PhonePe gateway with biometric authentication.',
          'Push notifications for transactions and offers.',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/developer?id=AGSKART+PRIVATE+LIMITED',
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(context, '🚀 Projects'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            int columns;
            if (screenWidth >= 1000) {
              columns = 3;
            } else if (screenWidth >= 700) {
              columns = 2;
            } else {
              columns = 1;
            }
            const gap = 14.0;
            final cardWidth = (maxW - (gap * (columns - 1))) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final p in projects)
                  SizedBox(
                    width: cardWidth,
                    child: ProjectCard(project: p),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class Project {
  final String title;
  final String tech;
  final String period;
  final List<String> points;
  final String? appStoreUrl;
  final String? playStoreUrl;

  Project({
    required this.title,
    required this.tech,
    required this.period,
    required this.points,
    this.appStoreUrl,
    this.playStoreUrl,
  });
}

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: _hovering ? 1.02 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: const Color(0xFF151923),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering
                  ? const Color(0xFF7DD3FC)
                  : const Color(0xFF2A3242),
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: const Color(0xFF7DD3FC).withValues(alpha: 0.2),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(20),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _handleOpenStore,
                  child: Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.project.tech,
                  style: const TextStyle(color: Color(0xFF7DD3FC)),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.project.period,
                  style: const TextStyle(color: Color(0xFF9AA4B2)),
                ),
                const SizedBox(height: 10),
                for (final pt in widget.project.points)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '• $pt',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const Spacer(),
                if (widget.project.appStoreUrl != null ||
                    widget.project.playStoreUrl != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        if (widget.project.playStoreUrl != null)
                          _StoreButton(
                            icon: Icons.android,
                            label: 'Play Store',
                            onTap: () => _openUrl(widget.project.playStoreUrl!),
                          ),
                        if (widget.project.appStoreUrl != null)
                          _StoreButton(
                            icon: Icons.apple,
                            label: 'App Store',
                            onTap: () => _openUrl(widget.project.appStoreUrl!),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOpenStore() {
    final hasApple = widget.project.appStoreUrl != null;
    final hasPlay = widget.project.playStoreUrl != null;
    if (hasApple && !hasPlay) {
      _openUrl(widget.project.appStoreUrl!);
    } else if (!hasApple && hasPlay) {
      _openUrl(widget.project.playStoreUrl!);
    } else if (hasApple && hasPlay) {
      _showStoreChooser();
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showStoreChooser() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151923),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StoreButton(
                icon: Icons.apple,
                label: 'App Store',
                onTap: () {
                  Navigator.of(context).pop();
                  _openUrl(widget.project.appStoreUrl!);
                },
              ),
              _StoreButton(
                icon: Icons.android,
                label: 'Play Store',
                onTap: () {
                  Navigator.of(context).pop();
                  _openUrl(widget.project.playStoreUrl!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _StoreButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF0F1115),
        side: const BorderSide(color: Color(0xFF2A3242)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

// ---------------- EXPERIENCE ----------------
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(
        color: const Color(0xFF151923),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(context, '💼 Experience'),
          const SizedBox(height: 10),
          for (final e in experiences)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['role']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    e['company']!,
                    style: const TextStyle(color: Color(0xFF7DD3FC)),
                  ),
                  Text(
                    e['period']!,
                    style: const TextStyle(color: Color(0xFF9AA4B2)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    e['desc']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- EDUCATION ----------------
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(
        color: const Color(0xFF151923),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(context, '🎓 Education'),
          const SizedBox(height: 10),
          for (final e in education)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['degree']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    e['school']!,
                    style: const TextStyle(color: Color(0xFF7DD3FC)),
                  ),
                  Text(
                    e['period']!,
                    style: const TextStyle(color: Color(0xFF9AA4B2)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- CERTIFICATIONS ----------------
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      '🥇 Employee of the Month — 4× in one year',
      'Recognized for outstanding Flutter project delivery and innovation.',
    ];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151923),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(context, '🏅 Certifications & Achievements'),
          const SizedBox(height: 10),
          for (final i in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(i, style: Theme.of(context).textTheme.bodyMedium),
            ),
        ],
      ),
    );
  }
}

// ---------------- SKILLS ----------------
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      'Flutter Development',
      'Android Native Development',
      'Git & Version Control',
      'Dart Programming',
      'UI/UX Design (Figma)',
      'API Integration',
      'JavaScript & Node.js',
      'SQL & NoSQL Databases',
      'Docker & CI/CD',
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151923),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(context, '🔨 Technical Skills'),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map(
                  (s) => Chip(
                    label: Text(s),
                    backgroundColor: const Color(0xFF151923),
                    labelStyle: const TextStyle(color: Colors.white),
                    side: const BorderSide(color: Color(0xFF7DD3FC)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------- CONTACT ----------------
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildClickableText(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.blue[300],
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue[300],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151923),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2430)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(context, '📬 Contact'),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Let\'s collaborate and build something great!'),
              const SizedBox(height: 10),
              _buildClickableText(
                context,
                '📧 althafmdev@gmail.com',
                onTap: () => _launchUrl('mailto:althafmdev@gmail.com'),
              ),
              const SizedBox(height: 4),
              _buildClickableText(
                context,
                '🔗 linkedin.com/in/althafm2002',
                onTap: () => _launchUrl('https://linkedin.com/in/althafm2002'),
              ),
              const SizedBox(height: 4),
              _buildClickableText(
                context,
                '💻 github.com/AlthafMjeelani',
                onTap: () => _launchUrl('https://github.com/AlthafMjeelani'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- FOOTER ----------------
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '© 2025 Althaf | Flutter Dev',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
      ),
    );
  }
}

// ---------------- HELPER ----------------
Widget sectionTitle(BuildContext context, String text) => Text(
  text,
  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
    color: const Color(0xFF7DD3FC),
    fontWeight: FontWeight.bold,
  ),
);

// Simple fade+slide reveal animation wrapper
class AnimatedReveal extends StatefulWidget {
  final Widget child;
  const AnimatedReveal({super.key, required this.child});

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _offset = Tween(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
    // Start when inserted
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
