import 'package:flame/components.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/obstacles/obstacles.dart';

class Obstacle extends SpriteComponent with HasGameReference<FlameDinoGame> {
  Obstacle({
    required this.type,
    this.index = 0,
  }) : super();

  final ObstacleType type;
  final int index;

  bool get isVisible => x + width > 0;

  @override
  void onLoad() {
    sprite = type.sprite(game.sprite);
    position = Vector2(
      300 + (type.size.x * index) + type.multiplicator,
      300 - size.x + (type == ObstacleType.cactusBig ? 0 : 10),
    );

    super.onLoad();
  }

  @override
  void onMount() {
    size = type.size;

    addAll(type.generateHitboxes());
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= game.gameSpeed * dt;

    if (!isVisible) removeFromParent();
  }
}
