import 'package:example/game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_juice_box/components.dart';
import 'package:flame_juice_box/effects.dart';
import 'package:flame_juice_box/particles.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

void main() {
  runApp(const FlameJuiceBoxExample());
}

class ExampleContainer extends StatelessWidget {
  const ExampleContainer({
    required this.child,
    required this.title,
    super.key,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        NesContainer(
          width: 200,
          height: 200,
          backgroundColor: Colors.black,
          padding: const EdgeInsets.all(4),
          child: child,
        ),
      ],
    );
  }
}

class FlameJuiceBoxExample extends StatelessWidget {
  const FlameJuiceBoxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: flutterNesTheme(),
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.grey[600],
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: NesContainer(
                child: NesSingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox.square(
                        dimension: 150,
                        child: Image.asset('assets/flame_juice_box.png'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Flame Juice Box',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Effects',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        children: [
                          ExampleContainer(
                            title: 'Bounce Effect',
                            child: GameWidget.controlled(
                              gameFactory: () => FlameJuiceBoxGame(
                                children: [
                                  GreenSquare(
                                    children: [
                                      BounceEffect(Vector2(0, -50)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ExampleContainer(
                            title: 'Spin Effect',
                            child: GameWidget.controlled(
                              gameFactory: () => FlameJuiceBoxGame(
                                children: [
                                  GreenSquare(
                                    children: [SpinEffect()],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ExampleContainer(
                            title: 'Pulse Effect',
                            child: GameWidget.controlled(
                              gameFactory: () => FlameJuiceBoxGame(
                                children: [
                                  GreenSquare(
                                    children: [PulseEffect()],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Particles',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        children: [
                          ExampleContainer(
                            title: 'Fire Particles',
                            child: GameWidget.controlled(
                              gameFactory: () => FlameJuiceBoxGame(
                                children: [
                                  FireParticles(
                                    lifespan: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Components',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        children: [
                          ExampleContainer(
                            title: 'Float and Fade Component',
                            child: GameWidget.controlled(
                              gameFactory: () {
                                late final FlameJuiceBoxGame game;

                                // ignore: join_return_with_assignment
                                game = FlameJuiceBoxGame(
                                  children: [
                                    TimerComponent(
                                      period: 2,
                                      repeat: true,
                                      onTick: () {
                                        game.world.add(
                                          FloatAndFadeComponent(
                                            anchor: Anchor.center,
                                            offset: Vector2(0, -50),
                                            child: GreenSquare(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );

                                return game;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
