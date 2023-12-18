import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/home_page.dart';
import 'package:flame_dino/utils/button_component.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';

class StartGameOverlay extends Component with ParentIsA<HomePage> {
  bool isVisible = true;

  @override
  Future<void> onLoad() async {
    add(StartGameText());
    add(StartButtons(parentCallback: parent.start));
  }

  @override
  void renderTree(Canvas canvas) {
    if (isVisible) {
      super.renderTree(canvas);
    }
  }
}

class StartGameText extends PositionComponent
    with HasGameReference<FlameDinoGame> {
  StartGameText()
      : super(
          size: Vector2(382, 25),
        );

  @override
  Future<void> onLoad() async {
    add(
      TextComponent(
        text: 'tap to start game',
        textRenderer: TextPaint(
          style: const m.TextStyle(
            fontFamily: 'ArcadeClassic',
            color: Color(0xFF525252),
            fontSize: 24,
            letterSpacing: 12,
          ),
        ),
        position: Vector2(0, size.y * .2),
      ),
    );
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(gameSize.x / 2 - size.x / 2, gameSize.y * .2);
  }
}

class StartButtons extends PositionComponent
    with TapCallbacks, HasGameReference<FlameDinoGame> {
  StartButtons({required this.parentCallback})
      : super(
          size: Vector2(72, 64),
        );

  final void Function() parentCallback;

  @override
  Future<void> onLoad() async {
    add(ButtonSprite(
      text: 'start',
      onTap: parentCallback,
    ));
    add(ButtonSprite(
      text: 'choose dino',
      onTap: () => game.overlays.add('choose_dino'),
      buttonIndex: 1,
    )..size = Vector2(320, 52));
  }
}
