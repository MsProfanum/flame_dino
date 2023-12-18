import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_dino/home_page.dart';
import 'package:flame_dino/obstacles/obstacles.dart';

class ObstaclesComponent extends Component with ParentIsA<HomePage> {
  final _random = Random();

  @override
  void update(double dt) {
    List<Obstacle> currentObstacles = children.query<Obstacle>();

    if (currentObstacles.isEmpty || !currentObstacles.last.isVisible) {
      _generateNewObstacle();
    }
  }

  void _generateNewObstacle() {
    final noOfObstacles = _random.nextInt(3) + 1;

    final obstacleType =
        _random.nextBool() ? ObstacleType.cactusSmall : ObstacleType.cactusBig;

    for (int i = 0; i < noOfObstacles; i++) {
      add(
        Obstacle(type: obstacleType, index: i),
      );
    }
  }

  void reset() {
    removeAll(children);
  }
}
