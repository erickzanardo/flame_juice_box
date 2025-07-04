import 'dart:async';

import 'package:flame/components.dart';

class BlinkEffect extends Component with ParentIsA<HasPaint> {
  BlinkEffect({
    this.interval = 0.5,
    this.resetOpacityValue = 1.0,
  });

  final double interval;
  final double resetOpacityValue;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(
      TimerComponent(
        period: interval,
        repeat: true,
        onTick: () {
          if (parent.opacity == 1) {
            parent.opacity = 0;
          } else {
            parent.opacity = 1;
          }
        },
      ),
    );
  }

  @override
  void onRemove() {
    parent.opacity = resetOpacityValue;
    super.onRemove();
  }
}
