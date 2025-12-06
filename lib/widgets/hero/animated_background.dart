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
  late AnimationController _planetRotationController;
  late AnimationController _starTwinkleController;
  final List<Star> _stars = [];
  final List<Planet> _planets = [];
  final List<Particle> _particles = [];
  final List<GeometricShape> _shapes = [];

  @override
  void initState() {
    super.initState();

    // Planet rotation controller
    _planetRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // Star twinkle controller
    _starTwinkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Minimal controllers for subtle animations
    _controllers = List.generate(5, (index) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 3000 + (index * 500)),
      )..repeat();
      return controller;
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Initialize stars
    _initializeStars();
    // Initialize planets
    _initializePlanets();
    // Initialize particles
    _initializeParticles();
    // Initialize geometric shapes
    _initializeShapes();
  }

  void _initializeStars() {
    final random = math.Random();
    for (int i = 0; i < 50; i++) {
      _stars.add(
        Star(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 0.5 + random.nextDouble() * 1,
          twinkleSpeed: 0.3 + random.nextDouble() * 0.7,
          baseOpacity: 0.1 + random.nextDouble() * 0.3,
        ),
      );
    }
  }

  void _initializePlanets() {
    _planets.add(
      Planet(
        type: PlanetType.earth,
        x: 0.15,
        y: 0.3,
        size: 40,
        rotationSpeed: 0.005,
      ),
    );
    _planets.add(
      Planet(
        type: PlanetType.mars,
        x: 0.85,
        y: 0.7,
        size: 30,
        rotationSpeed: 0.006,
      ),
    );
  }

  void _initializeParticles() {
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 2 + random.nextDouble() * 3,
          speed: 0.2 + random.nextDouble() * 0.3,
          opacity: 0.1 + random.nextDouble() * 0.2,
        ),
      );
    }
  }

  void _initializeShapes() {
    final random = math.Random();
    for (int i = 0; i < 15; i++) {
      _shapes.add(
        GeometricShape(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 8 + random.nextDouble() * 12,
          type: random.nextBool() ? ShapeType.circle : ShapeType.square,
          rotation: random.nextDouble() * 2 * math.pi,
          opacity: 0.05 + random.nextDouble() * 0.15,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    _planetRotationController.dispose();
    _starTwinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _planetRotationController,
              _starTwinkleController,
              ..._animations,
            ]),
            builder: (context, child) {
              return CustomPaint(
                painter: _SpaceBackgroundPainter(
                  _animations,
                  _stars,
                  _planets,
                  _particles,
                  _shapes,
                  _planetRotationController.value,
                  _starTwinkleController.value,
                  isDark,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double twinkleSpeed;
  final double baseOpacity;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleSpeed,
    required this.baseOpacity,
  });
}

enum PlanetType { earth, mars }

class Planet {
  final PlanetType type;
  final double x;
  final double y;
  final double size;
  final double rotationSpeed;

  Planet({
    required this.type,
    required this.x,
    required this.y,
    required this.size,
    required this.rotationSpeed,
  });
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

enum ShapeType { circle, square }

class GeometricShape {
  final double x;
  final double y;
  final double size;
  final ShapeType type;
  final double rotation;
  final double opacity;

  GeometricShape({
    required this.x,
    required this.y,
    required this.size,
    required this.type,
    required this.rotation,
    required this.opacity,
  });
}

class _SpaceBackgroundPainter extends CustomPainter {
  final List<Animation<double>> animations;
  final List<Star> stars;
  final List<Planet> planets;
  final List<Particle> particles;
  final List<GeometricShape> shapes;
  final double planetRotation;
  final double starTwinkle;
  final bool isDark;

  _SpaceBackgroundPainter(
    this.animations,
    this.stars,
    this.planets,
    this.particles,
    this.shapes,
    this.planetRotation,
    this.starTwinkle,
    this.isDark,
  ) : super(repaint: Listenable.merge(animations));

  @override
  bool shouldRebuildSemantics(_SpaceBackgroundPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.planetRotation != planetRotation ||
        oldDelegate.starTwinkle != starTwinkle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final backgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [
              const Color(0xFF000000),
              const Color(0xFF0A0E1A),
              const Color(0xFF000510),
            ]
          : [
              const Color(0xFF87CEEB),
              const Color(0xFFB0E0E6),
              const Color(0xFFE0F6FF),
            ],
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = backgroundGradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    // Draw stars with smooth movement
    for (int i = 0; i < stars.length; i++) {
      final star = stars[i];
      final phase = (starTwinkle + (i * 0.1)) % 1.0;
      final twinkle =
          (math.sin(phase * 2 * math.pi * star.twinkleSpeed) + 1) / 2;
      final opacity = star.baseOpacity * (0.7 + twinkle * 0.3);
      final starOpacity = isDark ? opacity * 0.5 : opacity * 0.2;

      // Add subtle movement
      final moveX = math.sin(phase * math.pi * 0.5) * 3;
      final moveY = math.cos(phase * math.pi * 0.3) * 3;

      canvas.drawCircle(
        Offset(star.x * size.width + moveX, star.y * size.height + moveY),
        star.size * (0.9 + twinkle * 0.2),
        Paint()
          ..color = Colors.white.withValues(alpha: starOpacity)
          ..style = PaintingStyle.fill,
      );
    }

    // Draw planets with floating animation
    for (int i = 0; i < planets.length; i++) {
      final planet = planets[i];
      // Use different animation phases for each planet
      final animationPhase = (planetRotation + (i * 0.3)) % 1.0;
      _drawPlanet(canvas, size, planet, animationPhase);
    }

    // Draw particles
    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];
      final phase = (starTwinkle + (i * 0.15)) % 1.0;
      final moveX = math.sin(phase * 2 * math.pi * particle.speed) * 10;
      final moveY = math.cos(phase * 2 * math.pi * particle.speed * 0.7) * 10;

      canvas.drawCircle(
        Offset(
          particle.x * size.width + moveX,
          particle.y * size.height + moveY,
        ),
        particle.size,
        Paint()
          ..color = isDark
              ? Colors.white.withValues(alpha: particle.opacity)
              : Colors.blue.withValues(alpha: particle.opacity * 0.3)
          ..style = PaintingStyle.fill,
      );
    }

    // Draw geometric shapes
    for (int i = 0; i < shapes.length; i++) {
      final shape = shapes[i];
      final phase = (planetRotation + (i * 0.2)) % 1.0;
      final rotation = shape.rotation + phase * 0.1;
      final floatY = math.sin(phase * 2 * math.pi) * 5;

      canvas.save();
      canvas.translate(shape.x * size.width, shape.y * size.height + floatY);
      canvas.rotate(rotation);

      final shapePaint = Paint()
        ..color = isDark
            ? const Color(0xFF00D9FF).withValues(alpha: shape.opacity)
            : const Color(0xFF00B8E6).withValues(alpha: shape.opacity * 0.5)
        ..style = PaintingStyle.fill;

      if (shape.type == ShapeType.circle) {
        canvas.drawCircle(Offset.zero, shape.size, shapePaint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: shape.size * 2,
            height: shape.size * 2,
          ),
          shapePaint,
        );
      }

      canvas.restore();
    }

    // Draw subtle grid lines
    _drawGridLines(canvas, size);

    // Draw nebula clouds (subtle gradient overlays)
    if (isDark) {
      _drawNebula(canvas, size);
    } else {
      _drawClouds(canvas, size);
    }
  }

  void _drawPlanet(Canvas canvas, Size size, Planet planet, double rotation) {
    // Enhanced floating movement with smooth animation
    final floatOffset = math.sin(rotation * 2 * math.pi * 0.5) * 20;
    final horizontalDrift = math.cos(rotation * 2 * math.pi * 0.3) * 15;
    final centerX = planet.x * size.width + horizontalDrift;
    final centerY = planet.y * size.height + floatOffset;
    final radius =
        planet.size * (1 + math.sin(rotation * 2 * math.pi * 0.4) * 0.1);

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(rotation * 2 * math.pi * planet.rotationSpeed);

    switch (planet.type) {
      case PlanetType.earth:
        _drawEarth(canvas, radius, isDark);
        break;
      case PlanetType.mars:
        _drawMars(canvas, radius, isDark);
        break;
    }

    canvas.restore();
  }

  void _drawEarth(Canvas canvas, double radius, bool isDark) {
    // Subtle Earth
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()
        ..color = isDark
            ? const Color(0xFF4A90E2).withValues(alpha: 0.15)
            : const Color(0xFF6BB6FF).withValues(alpha: 0.1)
        ..style = PaintingStyle.fill,
    );
  }

  void _drawMars(Canvas canvas, double radius, bool isDark) {
    // Subtle Mars
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()
        ..color = isDark
            ? const Color(0xFFCD5C5C).withValues(alpha: 0.12)
            : const Color(0xFFE9967A).withValues(alpha: 0.08)
        ..style = PaintingStyle.fill,
    );
  }

  void _drawNebula(Canvas canvas, Size size) {
    // Very subtle nebula for dark mode
    final nebulaPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00D9FF).withValues(alpha: 0.02),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), nebulaPaint);
  }

  void _drawGridLines(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.blue.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vertical lines
    for (int i = 1; i < 8; i++) {
      final x = size.width * (i / 8);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Horizontal lines
    for (int i = 1; i < 6; i++) {
      final y = size.height * (i / 6);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  void _drawClouds(Canvas canvas, Size size) {
    // Very subtle clouds for light mode
    final cloudPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Draw minimal cloud shapes
    for (int i = 0; i < 3; i++) {
      final x = size.width * 0.3 * (i + 1.0);
      final y = size.height * (0.2 + (i * 0.2));
      final cloudSize = 60.0;

      canvas.drawCircle(Offset(x, y), cloudSize, cloudPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
