import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/layout.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flutter/material.dart' as m;

class ButtonSprite extends SpriteComponent
    with TapCallbacks, HasGameReference<FlameDinoGame> {
  ButtonSprite({
    required this.text,
    required this.onTap,
    this.buttonIndex = 0,
  }) : super(
          size: Vector2(200, 52),
          anchor: Anchor.center,
        );

  final String text;
  final void Function() onTap;
  final int buttonIndex;

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.buttonEmpty);
    position =
        Vector2(game.size.x / 2, (game.size.y * .5) + size.y * buttonIndex);

    add(
      AlignComponent(
        child: TextComponent(
          text: text,
          textRenderer: TextPaint(
            style: const m.TextStyle(
              fontFamily: 'ArcadeClassic',
              color: Color(0xFFFFFFFF),
              fontSize: 24,
              letterSpacing: 8,
            ),
          ),
          size: size,
        ),
        alignment: Anchor.center,
      ),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    FlameAudio.play('select.mp3');
    onTap();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(
      game.size.x / 2,
      (game.size.y * .4) + size.y * buttonIndex,
    );
  }
}
