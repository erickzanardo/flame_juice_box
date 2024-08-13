import 'package:flame/effects.dart';

class SpinEffect extends SequenceEffect {
  SpinEffect({
    double duration = 1,
  }) : super(
          [
            RotateEffect.to(
              6.28,
              LinearEffectController(duration),
            ),
            RotateEffect.to(
              0,
              LinearEffectController(0),
            ),
          ],
          infinite: true,
        );
}
