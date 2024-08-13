import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// An effect that moves the component by a given offset with a bounce effect.
class BounceEffect extends MoveByEffect {
  BounceEffect(
    Vector2 offset, {
    double duration = 0.15,
    double interval = 0.02,
    Curve curve = Curves.ease,
    this.resetOnFinish = false,
  }) : super(
          offset,
          EffectController(
            duration: duration,
            reverseDuration: duration,
            startDelay: interval,
            atMinDuration: interval * 2,
            curve: curve,
            infinite: true,
          ),
        );

  final bool resetOnFinish;

  late Vector2? _originalPosition;

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();

    _originalPosition = target.position.clone();
  }

  @override
  @mustCallSuper
  void onRemove() {
    super.onRemove();

    if (resetOnFinish && _originalPosition != null) {
      target.position = _originalPosition!;
    }
  }
}
