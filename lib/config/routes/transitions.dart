import 'package:flutter/material.dart';

/// Transición de fade entre pantallas
Widget fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
    child: child,
  );
}

/// Transición de slide horizontal
Widget slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  final tween = Tween(begin: begin, end: end).chain(
    CurveTween(curve: curve),
  );

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}

/// Transición de slide desde abajo
Widget slideUpTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(0.0, 0.3);
  const end = Offset.zero;
  const curve = Curves.easeOutCubic;

  final tween = Tween(begin: begin, end: end).chain(
    CurveTween(curve: curve),
  );

  final fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(
    CurveTween(curve: curve),
  );

  return SlideTransition(
    position: animation.drive(tween),
    child: FadeTransition(
      opacity: animation.drive(fadeTween),
      child: child,
    ),
  );
}

/// Transición de scale
Widget scaleTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const curve = Curves.easeInOut;

  final scaleTween = Tween<double>(begin: 0.9, end: 1.0).chain(
    CurveTween(curve: curve),
  );

  final fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(
    CurveTween(curve: curve),
  );

  return ScaleTransition(
    scale: animation.drive(scaleTween),
    child: FadeTransition(
      opacity: animation.drive(fadeTween),
      child: child,
    ),
  );
}

/// Transición combinada de fade y scale
Widget fadeScaleTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const curve = Curves.easeInOut;

  final scaleTween = Tween<double>(begin: 0.95, end: 1.0).chain(
    CurveTween(curve: curve),
  );

  final fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(
    CurveTween(curve: curve),
  );

  return FadeTransition(
    opacity: animation.drive(fadeTween),
    child: ScaleTransition(
      scale: animation.drive(scaleTween),
      child: child,
    ),
  );
}
