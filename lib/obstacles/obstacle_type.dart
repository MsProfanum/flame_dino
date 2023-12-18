import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ObstacleType {
  ObstacleType._({
    required this.type,
    required this.size,
    required this.multiplicator,
    required this.generateHitboxes,
  });

  final ObstacleTypeEnum type;
  final Vector2 size;
  final double multiplicator;
  final List<ShapeHitbox> Function() generateHitboxes;

  static final cactusSmall = ObstacleType._(
    type: ObstacleTypeEnum.cactusSmall,
    size: Vector2(34, 70),
    multiplicator: 400,
    generateHitboxes: () => [
      RectangleHitbox(
        position: Vector2(5.0, 7.0),
        size: Vector2(10.0, 54.0),
      ),
      RectangleHitbox(
        position: Vector2(5.0, 7.0),
        size: Vector2(12.0, 68.0),
      ),
      RectangleHitbox(
        position: Vector2(15.0, 4.0),
        size: Vector2(14.0, 28.0),
      ),
    ],
  );
  static final cactusBig = ObstacleType._(
    type: ObstacleTypeEnum.cactusBig,
    size: Vector2(50, 100),
    multiplicator: 600,
    generateHitboxes: () => [
      RectangleHitbox(
        position: Vector2(0.0, 26.0),
        size: Vector2(14.0, 40.0),
      ),
      RectangleHitbox(
        position: Vector2(16.0, 0.0),
        size: Vector2(14.0, 98.0),
      ),
      RectangleHitbox(
        position: Vector2(28.0, 22.0),
        size: Vector2(20.0, 40.0),
      ),
    ],
  );

  Sprite sprite(Image spriteImage) => switch (type) {
        ObstacleTypeEnum.cactusSmall => Sprite(
            spriteImage,
            srcSize: size,
            srcPosition: Vector2(446.0, 2.0),
          ),
        ObstacleTypeEnum.cactusBig => Sprite(
            spriteImage,
            srcSize: size,
            srcPosition: Vector2(652.0, 2.0),
          ),
      };
}

enum ObstacleTypeEnum {
  cactusSmall,
  cactusBig,
}
