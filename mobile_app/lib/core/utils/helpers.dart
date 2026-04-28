import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
  
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
  
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'صباح الخير';
    } else if (hour < 18) {
      return 'مساء الخير';
    } else {
      return 'مساء النور';
    }
  }
  
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
  
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    ) ?? false;
  }
}
