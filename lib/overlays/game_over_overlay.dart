import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/home_page.dart';
import 'package:flame_dino/utils/button_component.dart';

class GameOverOverlay extends Component
    with HasGameReference<FlameDinoGame>, ParentIsA<HomePage> {
  @override
  FutureOr<void> onLoad() async {
    add(GameOverText());
    add(RestartButton(callback: parent.start));
    add(ButtonSprite(
      text: 'choose dino',
      onTap: () => game.overlays.add('choose_dino'),
      buttonIndex: 2,
    )..size = Vector2(320, 52));
  }
}

class GameOverText extends SpriteComponent
    with HasGameReference<FlameDinoGame> {
  GameOverText() : super(size: Vector2(382, 25), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.sprite,
      srcPosition: Vector2(955.0, 26.0),
      srcSize: size,
    );
    position = Vector2(game.size.x / 2, game.size.y * .3);
  }
}

class RestartButton extends SpriteComponent
    with HasGameReference<FlameDinoGame>, TapCallbacks {
  RestartButton({required this.callback})
      : super(size: Vector2(72, 80), anchor: Anchor.center);

  final void Function() callback;

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.sprite,
      srcPosition: Vector2.all(2.0),
      srcSize: size,
    );
    position = Vector2(game.size.x / 2, game.size.y * .5);
  }

  @override
  void onTapUp(TapUpEvent event) {
    FlameAudio.play('select.mp3');
    callback();
  }
}
