import 'package:flutter/material.dart';
import 'screens/portfolio_home.dart';

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
          surfaceBright: Color(0xFF0A0E1A),
          primary: Color(0xFF00D9FF),
          secondary: Color(0xFF1A1F2E),
          surface: Color(0xFF0F1419),
          onSurface: Color(0xFFE8EDF3),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
      ),
      home: const PortfolioHome(),
    );
  }
}
