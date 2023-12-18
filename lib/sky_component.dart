import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_dino/flame_dino_game.dart';

class SkyComponent extends Component with HasGameReference<FlameDinoGame> {
  SkyComponent();
  final _random = Random();

  @override
  void update(double dt) {
    super.update(dt);

    final numClouds = children.length;

    if (numClouds > 0) {
      final lastCloud = children.last as Cloud;

      if (numClouds < 10 && (lastCloud.x < game.size.x * 0.7)) {
        _generateNewCloud();
      }
    } else {
      add(Cloud(cloudPosition: Vector2(game.size.x - 50, 100)));
    }
  }

  void _generateNewCloud() {
    const minY = 30;
    const maxY = 150;

    final Vector2 position = Vector2(game.size.x + _random.nextInt(80) + 20,
        (_random.nextInt(maxY) + minY).toDouble());
    add(
      Cloud(cloudPosition: position),
    );
  }

  void reset() {
    removeAll(children);
  }
}

class Cloud extends SpriteComponent with HasGameRef<FlameDinoGame> {
  Cloud({
    required this.cloudPosition,
  }) : super(size: Vector2(92, 28));

  bool get isVisible => x + width > 0;

  final Vector2 cloudPosition;

  final _random = Random();

  @override
  void onLoad() {
    sprite = Sprite(
      game.sprite,
      srcPosition: Vector2(166.0, 2.0),
      srcSize: size,
    );
    position = cloudPosition;
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= game.gameSpeed * dt * min(0.3, _random.nextDouble());

    if (!isVisible) {
      removeFromParent();
    }
  }
}
