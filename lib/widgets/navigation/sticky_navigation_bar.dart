import 'dart:ui';

import 'package:flutter/material.dart';
import '../../utils/theme_provider.dart';

class StickyNavigationBar extends StatefulWidget {
  final String activeSection;
  final Function(String) onSectionTap;
  final ThemeProvider themeProvider;

  const StickyNavigationBar({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.themeProvider,
  });

  @override
  State<StickyNavigationBar> createState() => _StickyNavigationBarState();
}

class _StickyNavigationBarState extends State<StickyNavigationBar> {
  bool _isMobileMenuOpen = false;

  final List<Map<String, String>> _sections = [
    {'id': 'home', 'label': 'Home'},
    {'id': 'about', 'label': 'About'},
    {'id': 'projects', 'label': 'Projects'},
    {'id': 'experience', 'label': 'Experience'},
    {'id': 'education', 'label': 'Education'},
    {'id': 'skills', 'label': 'Skills'},
    {'id': 'contact', 'label': 'Contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Builder(
          builder: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Container(
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF0F1419).withValues(alpha: 0.95)
                    : const Color(0xFFE0F6FF).withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? const Color(0xFF1A1F2E).withValues(alpha: 0.5)
                        : const Color(0xFFB0E0E6).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey).withValues(
                      alpha: 0.3,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 40 : 20,
                      vertical: 16,
                    ),
                    child: isWide ? _buildDesktopNav() : _buildMobileNav(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Theme Toggle Button
        _buildThemeToggle(),
        // Navigation Items
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _sections.map((section) {
            final isActive = widget.activeSection == section['id'];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => widget.onSectionTap(section['id']!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isActive
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Text(
                      section['label']!,
                      style: TextStyle(
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // Spacer for symmetry
        SizedBox(width: 60),
      ],
    );
  }

  Widget _buildThemeToggle() {
    return ListenableBuilder(
      listenable: widget.themeProvider,
      builder: (context, child) {
        final isDark = widget.themeProvider.isDarkMode;
        return GestureDetector(
          onTap: () {
            widget.themeProvider.toggleTheme();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                ],
              ),
              shape: BoxShape.circle,
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
                  ).colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight_round,
                key: ValueKey(isDark),
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildThemeToggle(),
            IconButton(
              icon: Icon(
                _isMobileMenuOpen ? Icons.close : Icons.menu,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                setState(() {
                  _isMobileMenuOpen = !_isMobileMenuOpen;
                });
              },
            ),
          ],
        ),
        if (_isMobileMenuOpen)
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: _sections.map((section) {
                final isActive = widget.activeSection == section['id'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      widget.onSectionTap(section['id']!);
                      setState(() {
                        _isMobileMenuOpen = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isActive
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Text(
                        section['label']!,
                        style: TextStyle(
                          color: isActive
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
