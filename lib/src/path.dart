import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:svg_path_transform/src/operation.dart';
import 'package:svg_path_transform/src/path_builder.dart';
import 'package:svg_path_transform/src/sub_path.dart';

/// A SVG Path object.
@immutable
class Path implements Operations<Path> {
  /// Creates a new path from a list of [subPaths].
  Path(List<SubPath> subPaths) : subPaths = List.unmodifiable(subPaths);

  /// Creates a empty path.
  const Path.empty() : subPaths = const [];

  /// Create a new path from a string.
  /// e.g `Path.fromString('M0,0 L1,1 Z')`
  factory Path.fromString(String path) {
    final parser = SvgPathStringSource(path);
    final normalizer = SvgPathNormalizer();

    final builder = PathBuilder();

    for (final seg in parser.parseSegments()) {
      normalizer.emitSegment(seg, builder);
    }

    return builder.finished();
  }

  /// Creates a path that represents a circle at ([cx], [cy]) with radius [r].
  /// That is a path made up for two 180 degree arcs.
  // Uses the paths as described here:
  // https://stackoverflow.com/questions/5737975/circle-drawing-with-svgs-arc-path
  factory Path.fromCircle(double cx, double cy, double r) => Path.fromString(
        'M${cx - r},$cy '
        'a$r,$r 0 1,0 ${r * 2},0 '
        'a$r,$r 0 1,0 -${r * 2},0 '
        'Z',
      );

  /// Creates a path that represents a ellipse at ([cx], [cy]) with radius [rx]
  /// and [ry].
  /// That is a path made up for two 180 degree arcs.
  // Uses the paths as described here:
  // https://stackoverflow.com/questions/5737975/circle-drawing-with-svgs-arc-path
  factory Path.fromEllipse(double cx, double cy, double rx, double ry) =>
      Path.fromString(
        'M${cx - rx},$cy '
        'a$rx,$ry 0 1,0 ${rx * 2},0 '
        'a$rx,$ry 0 1,0 -${rx * 2},0 '
        'Z',
      );

  /// The list of [SubPath]s that make up this path.
  final List<SubPath> subPaths;

  /// Returns the number of segments in all subpaths.
  int get length => subPaths.map((p) => p.length).sum;

  @override
  Path mirror(Axis axis, [double centerX = 0.0, double centerY = 0.0]) =>
      Path(subPaths.map((p) => p.mirror(axis, centerX, centerY)).toList());

  @override
  Path rotate(double angle, [double centerX = 0.0, double centerY = 0.0]) =>
      Path(subPaths.map((p) => p.rotate(angle, centerX, centerY)).toList());

  @override
  Path translate(num x, num y) =>
      Path(subPaths.map((p) => p.translate(x, y)).toList());

  @override
  Path scale(num scaleX, [num? scaleY]) =>
      Path(subPaths.map((p) => p.scale(scaleX, scaleY ?? scaleX)).toList());

  /// Returns a new [Path] with all subpaths reversed.
  Path reverse() => Path(subPaths.reversed.map((p) => p.reverse()).toList());

  /// Joins two paths together. e.g
  /// ```dart
  /// final a = Path.fromString('M0,0 L1,1 Z')
  /// final b = Path.fromString('M2,2 L3,3 Z');
  /// final c = a.join(b);
  /// // c == Path.fromString('M0,0 L1,1 Z   M2,2 L3,3 Z');
  /// ```
  Path concat(Path other) => Path([...subPaths, ...other.subPaths]);

  /// Returns the Path as a valid SVG path string.
  @override
  String toString() => subPaths.map((s) => s.toString()).join(' ');

  @override
  bool operator ==(Object other) =>
      other is Path &&
      const ListEquality<SubPath>().equals(subPaths, other.subPaths);

  @override
  int get hashCode => const ListEquality<SubPath>().hash(subPaths);
}
