import 'dart:async';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_dino/home_page.dart';
import 'package:flame_dino/overlays/chosen_dino/cubit/chosen_dino_cubit.dart';
import 'package:flame_dino/overlays/chosen_dino/dino_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlameDinoGame extends FlameGame with HasCollisionDetection {
  FlameDinoGame({required this.chosenDinoCubit});

  final ChosenDinoCubit chosenDinoCubit;

  late final RouterComponent router;
  late final SharedPreferences storage;

  late Image sprite;
  late Image dinoClassicSprite;
  late Image dinoDadSprite;
  late Image dinoMumSprite;
  late Image dinoChildSprite;
  late Image dinoEggSprite;
  late Image buttonEmpty;

  double gameSpeed = 0;

  @override
  Color backgroundColor() => const Color(0xfff7f7f7);

  @override
  FutureOr<void> onLoad() async {
    storage = await SharedPreferences.getInstance();

    final highScore = storage.getInt('high_score');
    if (highScore == null) {
      await storage.setInt('high_score', 0);
    }

    await FlameAudio.audioCache.loadAll(['point.mp3', 'jump.mp3', 'die.mp3']);
    sprite = await Flame.images.load('dino.png');
    dinoClassicSprite = await Flame.images.load('dino_classic_sprite.png');
    dinoDadSprite = await Flame.images.load('dino_dad_sprite.png');
    dinoMumSprite = await Flame.images.load('dino_mum_sprite.png');
    dinoChildSprite = await Flame.images.load('dino_child_sprite.png');
    dinoEggSprite = await Flame.images.load('dino_egg_sprite.png');
    buttonEmpty = await Flame.images.load('button_empty.png');

    await add(FlameBlocProvider<ChosenDinoCubit, DinoType>.value(
        value: chosenDinoCubit,
        children: [
          HomePage(),
        ]));

    await super.onLoad();
  }
}
