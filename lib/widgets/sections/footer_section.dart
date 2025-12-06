import 'package:flutter/material.dart';
import '../hero/animated_background.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          // Animated background (same as home)
          const AnimatedBackground(),
          // Content
          Center(
            child: Text(
              '© 2025 Althaf | Flutter Dev',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
