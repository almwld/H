import 'package:flutter/material.dart';
class HistoryIcon extends StatelessWidget {
  final double size; final Color? color;
  const HistoryIcon({super.key, this.size = 40, this.color});
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: (color ?? Colors.red).withOpacity(0.1), shape: BoxShape.circle),
    child: Icon(Icons.history, size: size * 0.5, color: color ?? Colors.red),
  );
}
