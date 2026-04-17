import 'package:flutter/material.dart';

class AppColors {
  // Core Colors
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFF4895EF);
  static const Color secondary = Color(0xFF3F37C9);
  static const Color accent = Color(0xFF4CC9F0);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0F172A);
  static const Color border = Color(0xFFE2E8F0);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color greenbottom = Color.fromARGB(255, 31, 197, 142);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color greyExtraLight = Color(0xFFF1F5F9);
  static const Color greyLight = Color(0xFFCBD5E1);
  static const Color greyMedium = Color(0xFF94A3B8);
  static const Color greyDark = Color(0xFF64748B);

  // Soft/Light Backgrounds
  static const Color blueLight = Color(0xFFE0E7FF);
  static const Color greenLight = Color(0xFFDCFCE7);
  static const Color purpleLight = Color(0xFFF3E8FF);
  static const Color orangeLight = Color(0xFFFFEDD5);
  static const Color pinkLight = Color(0xFFFCE7F3);

  // Specialized Colors
  static const Color navy = Color(0xFF1E293B);
  static const Color forestGreen = Color(0xFF065F46);
  static const Color skyBlue = Color(0xFF0EA5E9);
  static const Color verydarkgrayishblue = Color(0xFF334155);
  static const Color blueAccent = Color(0xFF2563EB);

  // Compatibility aliases
  static const Color green = success;
  static const Color orange = warning;
  static const Color red = error;
  static const Color softblue = info;
  static const Color greyBorder = border;

  // Gradient definitions
  static const List<Color> primaryGradient = [
    Color(0xFF4361EE),
    Color(0xFF4CC9F0)
  ];
}
