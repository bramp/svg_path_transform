import 'package:svg_path_transform/svg_path_transform.dart';
import 'package:test/test.dart';

void main() {
  test('SvgMoveTo equality', () {
    expect(
      const SvgMoveTo(10, 20),
      equals(const SvgMoveTo(10, 20)),
    );
    expect(
      const SvgMoveTo(10, 20),
      isNot(equals(const SvgMoveTo(10.1, 20))),
    );
  });

  test('SvgLineTo equality', () {
    expect(
      const SvgLineTo(10, 20),
      equals(const SvgLineTo(10, 20)),
    );
    expect(
      const SvgLineTo(10, 20),
      isNot(equals(const SvgLineTo(10.1, 20))),
    );
  });

  test('SvgCubicTo equality', () {
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      equals(const SvgCubicTo(10, 20, 30, 40, 50, 60)),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10.1, 20, 30, 40, 50, 60))),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10, 20.1, 30, 40, 50, 60))),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10, 20, 30.1, 40, 50, 60))),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10, 20, 30, 40.1, 50, 60))),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10, 20, 30, 40, 50.1, 60))),
    );
    expect(
      const SvgCubicTo(10, 20, 30, 40, 50, 60),
      isNot(equals(const SvgCubicTo(10, 20, 30, 40, 50, 60.1))),
    );
  });
}
