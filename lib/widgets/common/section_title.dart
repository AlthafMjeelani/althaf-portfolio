import 'package:flutter/material.dart';

Widget sectionTitle(BuildContext context, String text, {IconData? icon}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isWide = screenWidth >= 800;

  return Column(
    children: [
      if (icon != null)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: isWide ? 32 : 28,
          ),
        ),
      if (icon != null) const SizedBox(height: 16),
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ).createShader(bounds),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w900,
            fontSize: isWide ? 48 : 36,
            letterSpacing: -1,
            height: 1.2,
          ),
        ),
      ),
    ],
  );
}
