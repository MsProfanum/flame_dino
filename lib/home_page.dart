import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_dino/dino.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/landscape.dart';
import 'package:flame_dino/obstacles/obstacles.dart';
import 'package:flame_dino/overlays/game_over_overlay.dart';
import 'package:flame_dino/overlays/start_game_overlay.dart';
import 'package:flame_dino/sky_component.dart';

class HomePage extends PositionComponent
    with HasGameReference<FlameDinoGame>, TapCallbacks {
  final double initialGameSpeed = 400;
  final double maxGameSpeed = 3000;

  double _distance = 0;

  GameStatus status = GameStatus.start;

  final dino = Dino();
  final landscape = Landscape();
  final skyComponent = SkyComponent();
  final obstacles = ObstaclesComponent();
  final gameOverOverlay = GameOverOverlay();
  final startGameOverlay = StartGameOverlay();

  int score = 0;

  late TextComponent scoreText;
  @override
  Future<void> onLoad() async {
    size = game.size;
    position = Vector2.zero();

    const chars = '0123456789HI ';
    final renderer = SpriteFontRenderer.fromFont(
      SpriteFont(
        source: game.sprite,
        size: 23,
        ascent: 23,
        glyphs: [
          for (var i = 0; i < chars.length; i++)
            Glyph(chars[i], left: 954.0 + 20 * i, top: 0, width: 20),
        ],
      ),
      letterSpacing: 2,
    );

    scoreText = TextComponent(
      text: 'HI ${game.storage.getInt('high_score')} $score',
      textRenderer: renderer,
      position: Vector2(20, 20),
    );

    add(startGameOverlay);
    add(landscape);
    add(skyComponent);
    add(scoreText);
    add(obstacles);
    add(dino);

    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (status != GameStatus.playing) return;

    _distance += dt * game.gameSpeed;
    score = _distance ~/ 50;
    game.gameSpeed = min(maxGameSpeed, game.gameSpeed + (dt * 10));

    scoreText.text = 'HI ${game.storage.getInt('high_score')} $score';
  }

  @override
  void onTapDown(TapDownEvent event) {
    dino.jump();
  }

  Future<void> gameOver() async {
    add(gameOverOverlay);
    game.gameSpeed = 0;
    status = GameStatus.gameOver;

    _distance = 0;

    final highScore = game.storage.getInt('high_score') ?? 0;
    if (highScore < score) {
      await game.storage.setInt('high_score', score);
    }
  }

  void start() {
    gameOverOverlay.removeFromParent();
    if (status == GameStatus.playing) return;

    status = GameStatus.playing;
    dino.reset();
    obstacles.reset();
    game.gameSpeed = initialGameSpeed;
    startGameOverlay.removeFromParent();
  }
}

enum GameStatus {
  playing,
  start,
  gameOver,
}
