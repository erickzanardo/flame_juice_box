import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flutter/animation.dart';

class FireParticles extends PositionComponent {
  FireParticles({
    required this.lifespan,
    this.count = 20,
    this.particleSize = 4,
    double height = 18,
    double width = 6,
    List<ColorTween>? colors,
    super.position,
    super.priority,
  }) {
    _xNoise = Tween(begin: -width / 2, end: width / 2);
    _yNoise = Tween(begin: -1, end: -height);

    this.colors = colors ??
        [
          ColorTween(
            begin: const Color(0xFFe16d50),
            end: const Color(0xFF6b3325),
          ),
          ColorTween(
            begin: const Color(0xFFe8b85c),
            end: const Color(0xFF806532),
          ),
        ];
  }

  final double lifespan;
  final int count;
  final double particleSize;

  late final Tween<double> _xNoise;
  late final Tween<double> _yNoise;

  final random = Random();

  late final List<ColorTween> colors;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(
      TimerComponent(
        period: .04,
        repeat: true,
        onTick: _emmit,
      ),
    );
  }

  void _emmit() {
    final colorTween = colors[random.nextInt(colors.length)];
    final particle = ParticleSystemComponent(
      position: Vector2(
        random.nextDouble() * 2,
        random.nextDouble() * 2,
      ),
      particle: Particle.generate(
        count: (count * random.nextDouble()).ceil(),
        generator: (i) {
          return AcceleratedParticle(
            lifespan: 1,
            speed: Vector2(
                  _xNoise.transform(random.nextDouble()),
                  _yNoise.transform(random.nextDouble()),
                ) *
                i.toDouble(),
            child: ComponentParticle(
              component: _FireParticle(
                size: Vector2.all(random.nextDouble() * particleSize),
                color: colorTween.transform(random.nextDouble())!,
                lifespan: lifespan,
              ),
            ),
          );
        },
      ),
    );

    add(particle);
  }
}

class _FireParticle extends RectangleComponent {
  _FireParticle({
    required Color color,
    required this.lifespan,
    super.size,
  }) : super(
          paint: Paint()..color = color,
        );

  final double lifespan;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(
      ScaleEffect.to(
        Vector2.zero(),
        CurvedEffectController(lifespan, Curves.easeOut),
      ),
    );
  }
}
