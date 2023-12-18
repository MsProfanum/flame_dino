import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/home_page.dart';
import 'package:flame_dino/obstacles/obstacles.dart';
import 'package:flame_dino/overlays/chosen_dino/cubit/chosen_dino_cubit.dart';
import 'package:flame_dino/overlays/chosen_dino/dino_type.dart';

class Dino extends SpriteAnimationGroupComponent<DinoStatus>
    with
        HasGameReference<FlameDinoGame>,
        CollisionCallbacks,
        ParentIsA<HomePage>,
        FlameBlocListenable<ChosenDinoCubit, DinoType> {
  Dino() : super(size: Vector2(90, 88));

  double jumpVelocity = 0.0;

  double get groundY => game.size.y / 2 + size.x / 2 + 10;

  late Image activeDinoSprite;

  @override
  FutureOr<void> onLoad() {
    activeDinoSprite = _getActiveDinoSprite(DinoType.dinoClassic);

    _generateAnimations();
    current = DinoStatus.running;

    position = Vector2(50, groundY);
    add(
      RectangleHitbox.relative(
        Vector2(0.3, 0.2),
        position: Vector2(20, height - 20),
        parentSize: size,
      ),
    );
    add(
      RectangleHitbox.relative(
        Vector2(0.2, 0.4),
        position: Vector2(5, height / 4),
        parentSize: size,
      ),
    );
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.5),
        position: Vector2(20, height / 3),
        parentSize: size,
      ),
    );
    add(
      RectangleHitbox.relative(
        Vector2(0.45, 0.35),
        position: Vector2(width / 2, 0),
        parentSize: size,
      ),
    );
  }

  void _generateAnimations() {
    animations = {
      DinoStatus.running: SpriteAnimation(
        [
          SpriteAnimationFrame(
              Sprite(
                activeDinoSprite,
                srcSize: size,
                srcPosition: Vector2(176.0, 0.0),
              ),
              0.15),
          SpriteAnimationFrame(
              Sprite(activeDinoSprite,
                  srcSize: size, srcPosition: Vector2(264.0, 0.0)),
              0.15),
        ],
      ),
      DinoStatus.jumping: SpriteAnimation(
        [
          SpriteAnimationFrame(
              Sprite(activeDinoSprite,
                  srcSize: size, srcPosition: Vector2(0.0, 0.0)),
              0.2),
        ],
      ),
      DinoStatus.dead: SpriteAnimation(
        [
          SpriteAnimationFrame(
              Sprite(activeDinoSprite,
                  srcSize: size, srcPosition: Vector2(352.0, 0.0)),
              0.2),
        ],
      ),
    };
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (current == DinoStatus.jumping) {
      y -= (jumpVelocity - (game.gameSpeed / parent.initialGameSpeed));
      jumpVelocity -= 0.8;

      if (y >= groundY) {
        y = groundY;
        current = DinoStatus.running;
        jumpVelocity = 0.0;
      }
    }
  }

  @override
  void onNewState(DinoType state) {
    activeDinoSprite = _getActiveDinoSprite(state);
    _generateAnimations();

    super.onNewState(state);
  }

  Image _getActiveDinoSprite(DinoType type) {
    return switch (type) {
      DinoType.dinoClassic => game.dinoClassicSprite,
      DinoType.dinoDad => game.dinoDadSprite,
      DinoType.dinoMum => game.dinoMumSprite,
      DinoType.dinoChild => game.dinoChildSprite,
      DinoType.dinoEgg => game.dinoEggSprite,
    };
  }

  void jump() {
    if (current == DinoStatus.jumping || parent.status != GameStatus.playing) {
      return;
    }

    FlameAudio.play('jump.mp3');
    current = DinoStatus.jumping;
    jumpVelocity = 17;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Obstacle) {
      current = DinoStatus.dead;
      FlameAudio.play('die.mp3');
      parent.gameOver();
    }
  }

  void reset() {
    current = DinoStatus.running;
    y = groundY;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    y = groundY;
  }
}

enum DinoStatus {
  running,
  jumping,
  dead,
}
