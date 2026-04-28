import 'package:flutter/material.dart';
class ConsultationIcon extends StatelessWidget {
  final double size; final Color? color;
  const ConsultationIcon({super.key, this.size = 40, this.color});
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: (color ?? Colors.green).withOpacity(0.1), shape: BoxShape.circle),
    child: Icon(Icons.video_call, size: size * 0.5, color: color ?? Colors.green),
  );
}
