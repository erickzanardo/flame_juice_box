import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GreenSquare extends RectangleComponent {
  GreenSquare({
    super.children,
  }) : super(
          size: Vector2.all(100),
          paint: Paint()..color = const Color(0xFF00FF00),
          anchor: Anchor.center,
        );
}

class FlameJuiceBoxGame extends FlameGame {
  FlameJuiceBoxGame({
    required List<Component> children,
  }) {
    world.addAll(children);
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    camera = CameraComponent.withFixedResolution(
      width: 400,
      height: 400,
    );
  }
}
