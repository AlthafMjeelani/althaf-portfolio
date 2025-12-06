import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../utils/web_utils.dart';
import 'animated_background.dart';

class HeroHeader extends StatefulWidget {
  final Function(String)? onSectionTap;
  const HeroHeader({super.key, this.onSectionTap});

  @override
  State<HeroHeader> createState() => _HeroHeaderState();
}

class _HeroHeaderState extends State<HeroHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollIndicatorController;

  @override
  void initState() {
    super.initState();
    _scrollIndicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollIndicatorController.dispose();
    super.dispose();
  }

  void _downloadResume() {
    if (kIsWeb) {
      // Trigger download on web
      downloadFile(
        'assets/images/Althaf_Flutter_Developer_Resume.pdf',
        'Althaf_Flutter_Developer_Resume.pdf',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

    return SizedBox(
      height: screenHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // Animated Background
          const AnimatedBackground(),

          // Content - Centered
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Subtitle
                    Text(
                      'Flutter Developer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF00D9FF).withValues(alpha: 0.8),
                        fontSize: isWide ? 18 : 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Name - Large and Bold
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF00D9FF),
                          Color(0xFF00B8E6),
                          Color(0xFF0099CC),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ).createShader(bounds),
                      child: Text(
                        'Althaf M',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: isWide ? 96 : 56,
                          letterSpacing: -1.5,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // About Me Text with better formatting
                    Container(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Text(
                        "I'm a 23-year-old software engineer from Kozhikode, Kerala, passionate about crafting innovative tech solutions. With 3+ years of Flutter experience, I've built over 15 high-performance apps.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: isWide ? 20 : 16,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // CTA Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildCTAButton(
                          context: context,
                          label: 'View Projects',
                          icon: Icons.work_outline,
                          onTap: () {
                            widget.onSectionTap?.call('projects');
                          },
                        ),
                        _buildCTAButton(
                          context: context,
                          label: 'Download Resume',
                          icon: Icons.download_outlined,
                          onTap: _downloadResume,
                          isSecondary: false,
                        ),
                        _buildCTAButton(
                          context: context,
                          label: 'Get In Touch',
                          icon: Icons.email_outlined,
                          onTap: () {
                            widget.onSectionTap?.call('contact');
                          },
                          isSecondary: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scroll Indicator at Bottom
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _scrollIndicatorController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _scrollIndicatorController.value * 10),
                    child: Column(
                      children: [
                        Text(
                          'Scroll to explore',
                          style: TextStyle(
                            color: const Color(
                              0xFF00D9FF,
                            ).withValues(alpha: 0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: const Color(0xFF00D9FF).withValues(alpha: 0.7),
                          size: 32,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isSecondary = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: isSecondary
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
                  ),
            color: isSecondary ? Colors.transparent : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSecondary
                  ? const Color(0xFF00D9FF).withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSecondary
                ? null
                : [
                    BoxShadow(
                      color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
