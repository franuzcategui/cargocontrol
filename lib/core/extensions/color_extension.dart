import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  Color get mainColor => Theme.of(this).colorScheme.primary;
  Color get secondaryMainColor => Theme.of(this).colorScheme.secondary;
  Color get tertiaryMainColor => Theme.of(this).colorScheme.secondaryContainer;
  Color get quaternaryMainColor => Theme.of(this).colorScheme.onSecondary;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get textColor => Theme.of(this).colorScheme.onSurface;
  Color get textFieldColor => Theme.of(this).colorScheme.onPrimary;
  Color get secondaryTextColor => Theme.of(this).colorScheme.onPrimaryContainer;
}
