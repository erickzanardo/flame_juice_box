import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class PulseEffect extends SequenceEffect {
  PulseEffect({
    double duration = .8,
    double scale = .2,
  }) : super(
          [
            ScaleEffect.to(
              Vector2.all(1 + scale),
              CurvedEffectController(
                duration / 2,
                Curves.easeOut,
              ),
            ),
            ScaleEffect.to(
              Vector2.all(1),
              CurvedEffectController(
                duration / 2,
                Curves.easeIn,
              ),
            ),
          ],
          infinite: true,
        );
}
