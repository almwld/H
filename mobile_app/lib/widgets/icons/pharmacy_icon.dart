import 'package:flutter/material.dart';
class PharmacyIcon extends StatelessWidget {
  final double size; final Color? color;
  const PharmacyIcon({super.key, this.size = 40, this.color});
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: (color ?? Colors.blue).withOpacity(0.1), shape: BoxShape.circle),
    child: Icon(Icons.local_pharmacy, size: size * 0.5, color: color ?? Colors.blue),
  );
}
