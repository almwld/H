import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const ProfileIcon({super.key, this.size = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: (color ?? Colors.orange).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: color ?? Colors.orange,
      ),
    );
  }
}
