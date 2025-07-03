import 'dart:async';

import 'package:flame/components.dart';

class BlinkEffect extends Component with ParentIsA<HasPaint> {
  BlinkEffect({
    this.interval = 0.5,
  });

  final double interval;

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
    parent.opacity = 1;
    super.onRemove();
  }
}
