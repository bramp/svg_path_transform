import 'package:meta/meta.dart';

/// The axis to perform an operation on.
enum Axis {
  /// The x-axis.
  x,

  /// The y-axis.
  y
}

/// A set of operations that can be performed on a [T].
abstract class Operations<T> {
  /// Returns a new [T] translated by x and y.
  @useResult
  T translate(num x, num y);

  /// Returns a new [T] rotated [angle] radians around [centerX],[centerY].
  @useResult
  T rotate(double angle, [double centerX = 0.0, double centerY = 0.0]);

  /// Mirrors this over vertical or horizontal line that goes though
  /// [centerX],[centerY].
  // TODO(bramp): Support mirroring over a arbitrary line.
  @useResult
  T mirror(Axis axis, [double centerX = 0.0, double centerY = 0.0]);

  /// Scales by [scaleX] and [scaleY].
  /// scaleY defaults to scaleX if not provided.
  T scale(num scaleX, [num? scaleY]);
}
