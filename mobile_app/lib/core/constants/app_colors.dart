import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0D9488);
  static const Color primaryLight = Color(0xFF14B8A6);
  static const Color primaryDark = Color(0xFF0F766E);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryLight = Color(0xFFFBBF24);
  static const Color secondaryDark = Color(0xFFD97706);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color dark = Color(0xFF1F2937);
  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFE5E7EB);
  static const Color background = Color(0xFFF9FAFB);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
