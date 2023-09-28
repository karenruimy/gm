import 'package:flutter/material.dart';

extension ExtendedContext on BuildContext {
  /// [Theme] extension
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// [TextTheme] extension
  TextTheme get textTheme => Theme.of(this).textTheme;
}