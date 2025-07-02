// ignore_for_file: noop_primitive_operations

import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

final _defaultRandom = math.Random();

class ShakeEffect extends SequenceEffect {
  ShakeEffect({
    double duration = .008,
    double interval = .02,
    double xOffset = 10,
    double yOffset = 10,
    int times = 4,
    math.Random? random,
    super.onComplete,
  }) : super(
          [
            for (var i = 0; i < times; i++)
              MoveEffect.by(
                Vector2(
                  (xOffset *
                          (random ?? _defaultRandom).nextDouble() *
                          ((random ?? _defaultRandom).nextBool() ? 1 : -1))
                      .toDouble(),
                  (yOffset *
                          (random ?? _defaultRandom).nextDouble() *
                          ((random ?? _defaultRandom).nextBool() ? 1 : -1))
                      .toDouble(),
                ),
                DelayedEffectController(
                  LinearEffectController(duration),
                  delay: interval,
                ),
              ),
          ],
        );
}
