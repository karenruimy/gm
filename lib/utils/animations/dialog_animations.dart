import 'package:flutter/material.dart';

class DialogAnimations {
  /// Slide animation form left to right
  static SlideTransition fromLeft(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(animation),
      child: child,
    );
  }

  /// Slide animation form right to left
  static SlideTransition fromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(animation),
      child: child,
    );
  }

  /// Slide animation from top to center
  static SlideTransition fromTop(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero).animate(animation),
      child: child,
    );
  }

  /// Slide animation from bottom to center
  static SlideTransition fromBottom(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation),
      child: child,
    );
  }

  /// Scale animation with grow effect
  static ScaleTransition grow(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: const Interval(0.00, 0.50, curve: Curves.linear)),
      ),
      child: child,
    );
  }

  /// Scale animation with shrink effect
  static ScaleTransition shrink(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.2, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: const Interval(0.50, 1.00, curve: Curves.linear)),
      ),
      child: child,
    );
  }
}