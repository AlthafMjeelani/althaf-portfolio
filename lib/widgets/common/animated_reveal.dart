import 'package:flutter/material.dart';

// Scroll-triggered fade+slide reveal animation wrapper
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
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _offset = Tween(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_controller);

    // Check if widget is in viewport after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfInViewport();
      // Also check periodically for scroll-triggered animations
      _startPeriodicCheck();
    });
  }

  void _startPeriodicCheck() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_hasAnimated && mounted) {
        _checkIfInViewport();
        if (!_hasAnimated) {
          _startPeriodicCheck();
        }
      }
    });
  }

  void _checkIfInViewport() {
    if (_hasAnimated || !mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetHeight = renderBox.size.height;

    // Check if widget is in viewport (with some threshold - trigger when 200px before viewport)
    if (position.dy < screenHeight + 200 && position.dy + widgetHeight > -200) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-check when dependencies change
    if (!_hasAnimated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfInViewport();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!_hasAnimated) {
          _checkIfInViewport();
        }
        return false;
      },
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(position: _offset, child: widget.child),
      ),
    );
  }
}
