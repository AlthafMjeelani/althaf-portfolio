import 'package:flutter/material.dart';
import '../widgets/navigation/sticky_navigation_bar.dart';
import '../widgets/hero/hero_header.dart';
import '../widgets/common/animated_reveal.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/education_section.dart';
import '../widgets/sections/certifications_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/footer_section.dart';
import '../utils/theme_provider.dart';

class PortfolioHome extends StatefulWidget {
  final ThemeProvider themeProvider;
  const PortfolioHome({super.key, required this.themeProvider});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'experience': GlobalKey(),
    'education': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };
  String _activeSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Update active section based on scroll position
    final screenHeight = MediaQuery.of(context).size.height;

    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;
      if (context != null) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= screenHeight * 0.3 && position.dy >= -100) {
            if (_activeSection != entry.key) {
              setState(() {
                _activeSection = entry.key;
              });
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  key: _sectionKeys['home'],
                  child: HeroHeader(onSectionTap: _scrollToSection),
                ),
                Container(
                  key: _sectionKeys['about'],
                  child: const AnimatedReveal(child: AboutSection()),
                ),
                Container(
                  key: _sectionKeys['projects'],
                  child: const AnimatedReveal(child: ProjectsSection()),
                ),
                Container(
                  key: _sectionKeys['experience'],
                  child: const AnimatedReveal(child: ExperienceSection()),
                ),
                Container(
                  key: _sectionKeys['education'],
                  child: const AnimatedReveal(child: EducationSection()),
                ),
                const AnimatedReveal(child: CertificationsSection()),
                Container(
                  key: _sectionKeys['skills'],
                  child: const AnimatedReveal(child: SkillsSection()),
                ),
                Container(
                  key: _sectionKeys['contact'],
                  child: const AnimatedReveal(child: ContactSection()),
                ),
                const FooterSection(),
              ],
            ),
          ),
          // Sticky navigation bar at the top
          StickyNavigationBar(
            activeSection: _activeSection,
            onSectionTap: _scrollToSection,
            themeProvider: widget.themeProvider,
          ),
        ],
      ),
    );
  }
}
