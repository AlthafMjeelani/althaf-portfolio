import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    // More controllers for richer animations
    _controllers = List.generate(25, (index) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + (index * 150)),
      )..repeat();
      return controller;
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        final width = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : screenSize.width;
        final height =
            constraints.maxHeight.isFinite && constraints.maxHeight > 0
            ? constraints.maxHeight
            : screenSize.height;

        return SizedBox(
          width: width > 0 ? width : screenSize.width,
          height: height > 0 ? height : screenSize.height,
          child: CustomPaint(painter: _AnimatedBackgroundPainter(_animations)),
        );
      },
    );
  }
}

class _AnimatedBackgroundPainter extends CustomPainter {
  final List<Animation<double>> animations;

  _AnimatedBackgroundPainter(this.animations)
    : super(repaint: Listenable.merge(animations));

  @override
  void paint(Canvas canvas, Size size) {
    // Enhanced animated gradient mesh background
    final gradient1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(
          0xFF00D9FF,
        ).withValues(alpha: 0.15 + (animations[0].value * 0.1)),
        const Color(
          0xFF0099CC,
        ).withValues(alpha: 0.08 + (animations[1].value * 0.05)),
        Colors.transparent,
        const Color(
          0xFF00B8E6,
        ).withValues(alpha: 0.05 + (animations[2].value * 0.03)),
      ],
      stops: [
        0.0,
        0.2 + (animations[0].value * 0.3),
        0.6 + (animations[1].value * 0.2),
        1.0,
      ],
    );

    final gradient2 = RadialGradient(
      center: Alignment(-0.5 + animations[3].value, -0.3 + animations[4].value),
      radius: 1.5,
      colors: [
        const Color(0xFF00D9FF).withValues(alpha: 0.12),
        Colors.transparent,
      ],
    );

    final gradient3 = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        const Color(0xFF0099CC).withValues(alpha: 0.1),
        Colors.transparent,
        const Color(0xFF00D9FF).withValues(alpha: 0.08),
      ],
      stops: [0.0, 0.4 + (animations[5].value * 0.3), 1.0],
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = gradient1.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = gradient2.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = gradient3.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    // Enhanced animated particles with varying sizes and movements
    for (int i = 6; i < animations.length - 5; i++) {
      final progress = animations[i].value;
      final baseX = (size.width * 0.1) + (size.width * 0.8 * ((i * 0.618) % 1));
      final baseY =
          (size.height * 0.1) + (size.height * 0.8 * ((i * 0.382) % 1));

      // Circular motion
      final radius = 40 + (30 * (i % 4));
      final offsetX = radius * (i % 2 == 0 ? 1 : -1) * (progress * 2 - 1);
      final offsetY =
          radius * 0.6 * ((i % 3 == 0 ? 1 : -1)) * (progress * 2 - 1);

      final x = baseX + offsetX * 0.5;
      final y = baseY + offsetY * 0.5;

      final particleRadius =
          (15 + (25 * (i % 3))) * (0.6 + 0.4 * (progress * 2 - 1).abs());
      final alpha = 0.04 + 0.08 * (1 - (progress * 2 - 1).abs());

      // Outer glow
      canvas.drawCircle(
        Offset(x, y),
        particleRadius * 1.5,
        Paint()
          ..color = const Color(0xFF00D9FF).withValues(alpha: alpha * 0.3)
          ..style = PaintingStyle.fill,
      );

      // Main particle
      canvas.drawCircle(
        Offset(x, y),
        particleRadius,
        Paint()
          ..color = const Color(0xFF00D9FF).withValues(alpha: alpha)
          ..style = PaintingStyle.fill,
      );

      // Inner highlight
      canvas.drawCircle(
        Offset(x - particleRadius * 0.3, y - particleRadius * 0.3),
        particleRadius * 0.4,
        Paint()
          ..color = Colors.white.withValues(alpha: alpha * 0.5)
          ..style = PaintingStyle.fill,
      );
    }

    // Animated grid lines with varying opacity
    for (int i = 0; i < 15; i++) {
      final gridProgress = animations[animations.length - 5 + (i % 5)].value;
      final gridPaint = Paint()
        ..color = const Color(
          0xFF00D9FF,
        ).withValues(alpha: 0.03 + 0.04 * (1 - (gridProgress * 2 - 1).abs()))
        ..strokeWidth = 0.5;

      final offset = (gridProgress * 80) % 100;
      final y = (i * size.height / 15) + offset;
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    }

    for (int i = 0; i < 15; i++) {
      final gridProgress = animations[animations.length - 10 + (i % 5)].value;
      final gridPaint = Paint()
        ..color = const Color(
          0xFF00D9FF,
        ).withValues(alpha: 0.03 + 0.04 * (1 - (gridProgress * 2 - 1).abs()))
        ..strokeWidth = 0.5;

      final offset = (gridProgress * 80) % 100;
      final x = (i * size.width / 15) + offset;
      if (x >= 0 && x <= size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
    }

    // Floating geometric shapes
    for (int i = 0; i < 8; i++) {
      final shapeProgress = animations[animations.length - 15 + (i % 10)].value;
      final shapeX = size.width * (0.1 + (i * 0.12) % 0.8);
      final shapeY = size.height * (0.15 + (i * 0.15) % 0.7);
      final shapeSize = 20 + (15 * (i % 3));
      final rotation = shapeProgress * 2 * 3.14159;

      // Draw hexagons or triangles
      final path = Path();
      if (i % 2 == 0) {
        // Hexagon
        for (int j = 0; j < 6; j++) {
          final angle = (j * math.pi / 3) + rotation;
          final px =
              shapeX +
              shapeSize * 0.5 * (1 + shapeProgress * 0.3) * math.cos(angle);
          final py =
              shapeY +
              shapeSize * 0.5 * (1 + shapeProgress * 0.3) * math.sin(angle);
          if (j == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
      } else {
        // Triangle
        for (int j = 0; j < 3; j++) {
          final angle = (j * 2 * math.pi / 3) + rotation;
          final px =
              shapeX +
              shapeSize * 0.4 * (1 + shapeProgress * 0.2) * math.cos(angle);
          final py =
              shapeY +
              shapeSize * 0.4 * (1 + shapeProgress * 0.2) * math.sin(angle);
          if (j == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(
            0xFF00D9FF,
          ).withValues(alpha: 0.06 + 0.04 * (1 - (shapeProgress * 2 - 1).abs()))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
