import 'package:flutter/material.dart';
class DoctorIcon extends StatelessWidget {
  final double size; final Color? color;
  const DoctorIcon({super.key, this.size = 40, this.color});
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: (color ?? Colors.teal).withOpacity(0.1), shape: BoxShape.circle),
    child: Icon(Icons.medical_services, size: size * 0.5, color: color ?? Colors.teal),
  );
}
