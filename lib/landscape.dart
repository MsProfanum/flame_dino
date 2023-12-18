import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/home_page.dart';

class Landscape extends PositionComponent
    with HasGameReference<FlameDinoGame>, ParentIsA<HomePage> {
  Landscape() : super();

  final lineSize = Vector2(1200, 24);
  final Queue<SpriteComponent> groundLayers = Queue();
  late final Sprite littleBumpSprite;
  late final Sprite bigBumpSprite;

  @override
  FutureOr<void> onLoad() {
    littleBumpSprite = Sprite(
      game.sprite,
      srcPosition: Vector2(2.0, 104.0),
      srcSize: lineSize,
    );

    bigBumpSprite = Sprite(
      game.sprite,
      srcPosition: Vector2(game.sprite.width / 2, 104.0),
      srcSize: lineSize,
    );

    final newLines = _generateLines();
    groundLayers.addAll(newLines);
    addAll(groundLayers);

    y = (game.size.y * 0.8);

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = size.y * 0.8;
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (final line in groundLayers) {
      line.x -= game.gameSpeed * dt;
    }

    final firstLine = groundLayers.first;

    if (firstLine.x <= -firstLine.width) {
      groundLayers.remove(firstLine);
      firstLine.x = groundLayers.last.x + groundLayers.last.width;
      groundLayers.add(firstLine);
    }
  }

  List<SpriteComponent> _generateLines() {
    final number = 1 + (game.size.x / lineSize.x).ceil() - groundLayers.length;
    final lastX = (groundLayers.lastOrNull?.x ?? 0) +
        (groundLayers.lastOrNull?.width ?? 0);
    final random = Random();

    return List.generate(
      max(number, 0),
      (i) => SpriteComponent(
        sprite: random.nextBool() ? littleBumpSprite : bigBumpSprite,
        size: lineSize,
      )..x = lastX + lineSize.x * i,
      growable: false,
    );
  }
}
