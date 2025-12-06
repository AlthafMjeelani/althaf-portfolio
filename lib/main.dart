import 'package:flutter/material.dart';
import 'screens/portfolio_home.dart';
import 'utils/theme_provider.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'Althaf M | Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: _themeProvider.themeMode,
          home: PortfolioHome(themeProvider: _themeProvider),
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF00B8E6),
        secondary: Color(0xFF87CEEB),
        surface: Color(0xFFE0F6FF),
        surfaceBright: Color(0xFFF0F8FF),
        onSurface: Color(0xFF1A1F2E),
        onPrimary: Colors.white,
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFE0F6FF),
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFE0F6FF),
        foregroundColor: Color(0xFF1A1F2E),
        elevation: 0,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
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
      cardColor: const Color(0xFF1A1F2E),
    );
  }
}
