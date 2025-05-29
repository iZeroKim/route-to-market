import 'package:flutter/material.dart';

class StatusCardBase extends StatelessWidget {
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  const StatusCardBase({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.child,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(icon, color: iconColor),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
