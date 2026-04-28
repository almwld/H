import 'package:flutter/material.dart';

class PlatformIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const PlatformIcon({super.key, this.size = 80, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.teal.shade400, Colors.teal.shade800],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.health_and_safety,
          size: size * 0.6,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
