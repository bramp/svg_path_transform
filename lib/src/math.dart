import 'dart:math';

import 'package:svg_path_transform/src/operation.dart';

/// Rotates a point (x, y) around (centerX, centerY) by [radians].
(double, double) rotatePoint(
  double x,
  double y,
  double radians, [
  double centerX = 0.0,
  double centerY = 0.0,
]) {
  final cosA = cos(radians);
  final sinA = sin(radians);

  // Translate to origin
  final originX = x - centerX;
  final originY = y - centerY;

  // Rotate
  final newX = originX * cosA - originY * sinA;
  final newY = originX * sinA + originY * cosA;

  // Translate back
  return (
    newX + centerX,
    newY + centerY,
  );
}

/// Mirrors a point (x, y) over an [axis] that goes through (centerX, centerY).
// TODO(bramp): Change to support arbitrary line as the axis.
(double, double) mirrorPoint(
  double x,
  double y,
  Axis axis, [
  double centerX = 0.0,
  double centerY = 0.0,
]) {
  // Translate to origin
  var originX = x - centerX;
  var originY = y - centerY;

  // Flip over the appropriate axis
  if (axis == Axis.x) {
    originX = -originX;
  } else if (axis == Axis.y) {
    originY = -originY;
  }

  // Translate back
  return (
    originX + centerX,
    originY + centerY,
  );
}
