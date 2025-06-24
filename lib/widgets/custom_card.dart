// // TODO Implement this library.
// import 'package:flutter/material.dart';

// class CustomCard extends StatelessWidget {
//   final Widget child;

//   CustomCard({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       color: Color(0xFFF5F5DC), // Beige désert
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: child,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double elevation;
  final bool hasBorder;
  final Color borderColor;
  final double borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.color = const Color(0xFFF5F5DC), // Beige désert par défaut
    this.elevation = 4,
    this.hasBorder = false,
    this.borderColor = Colors.brown, // Couleur bordure désert
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: hasBorder
            ? BorderSide(color: borderColor, width: 1.5)
            : BorderSide.none,
      ),
      shadowColor: Colors.brown.withOpacity(0.3), // Ombre sable
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}