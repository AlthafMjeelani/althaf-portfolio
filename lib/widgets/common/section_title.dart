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
            color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00D9FF),
            size: isWide ? 32 : 28,
          ),
        ),
      if (icon != null) const SizedBox(height: 16),
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF00D9FF), Color(0xFF00B8E6)],
        ).createShader(bounds),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
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
