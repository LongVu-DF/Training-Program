import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  // Create an extension for buildcontext, now we can call context.colorScheme form anywere, dont need to creaete variable for Theme.of(context) many time. This will reduce to many function re-render
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
}
