import 'package:flutter/material.dart';
class AiIcon extends StatelessWidget {
  final double size; final Color? color;
  const AiIcon({super.key, this.size = 40, this.color});
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: (color ?? Colors.purple).withOpacity(0.1), shape: BoxShape.circle),
    child: Icon(Icons.psychology, size: size * 0.5, color: color ?? Colors.purple),
  );
}
