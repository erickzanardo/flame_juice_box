import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class FloatAndFadeComponent extends PositionComponent {
  FloatAndFadeComponent({
    required HasPaint child,
    super.position,
    super.size,
    super.priority,
    super.anchor,
    double fadingDelay = 0,
    Curve curve = Curves.ease,
    double duration = 1.5,
    Vector2? offset,
  }) {
    final animationOffset = offset ?? Vector2(0, -10);

    addAll([
      child,
      MoveEffect.by(
        animationOffset,
        CurvedEffectController(
          duration,
          curve,
        ),
      ),
    ]);

    add(
      TimerComponent(
        period: fadingDelay,
        onTick: () {
          child.add(
            OpacityEffect.to(
              0,
              CurvedEffectController(
                duration,
                curve,
              ),
            ),
          );
        },
      ),
    );
  }
}
