import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/overlays/chosen_dino/cubit/chosen_dino_cubit.dart';
import 'package:flame_dino/overlays/chosen_dino/dino_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChooseDinoOverlay extends StatelessWidget {
  const ChooseDinoOverlay({required this.game, super.key});

  final FlameDinoGame game;

  @override
  Widget build(BuildContext context) {
    final gameHighScore = game.storage.getInt('high_score') ?? 0;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose your dino',
              style: TextStyle(
                fontFamily: 'ArcadeClassic',
                fontSize: 24,
                letterSpacing: 8,
                color: Color(0xFF525252),
              ),
            ),
            const Gap(24),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _Dino(
                      dinoType: DinoType.dinoClassic,
                      onTapCallback: () {
                        context
                            .read<ChosenDinoCubit>()
                            .changeDino(DinoType.dinoClassic);
                        game.overlays.remove('choose_dino');
                      },
                      gameHighScore: gameHighScore,
                    ),
                    _Dino(
                      dinoType: DinoType.dinoDad,
                      onTapCallback: () {
                        context
                            .read<ChosenDinoCubit>()
                            .changeDino(DinoType.dinoDad);
                        game.overlays.remove('choose_dino');
                      },
                      gameHighScore: gameHighScore,
                    ),
                    _Dino(
                      dinoType: DinoType.dinoMum,
                      onTapCallback: () {
                        context
                            .read<ChosenDinoCubit>()
                            .changeDino(DinoType.dinoMum);
                        game.overlays.remove('choose_dino');
                      },
                      gameHighScore: gameHighScore,
                    ),
                    _Dino(
                      dinoType: DinoType.dinoChild,
                      onTapCallback: () {
                        context
                            .read<ChosenDinoCubit>()
                            .changeDino(DinoType.dinoChild);
                        game.overlays.remove('choose_dino');
                      },
                      gameHighScore: gameHighScore,
                    ),
                    _Dino(
                      dinoType: DinoType.dinoEgg,
                      onTapCallback: () {
                        context
                            .read<ChosenDinoCubit>()
                            .changeDino(DinoType.dinoEgg);
                        game.overlays.remove('choose_dino');
                      },
                      gameHighScore: gameHighScore,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dino extends StatelessWidget {
  const _Dino({
    required this.dinoType,
    this.onTapCallback,
    this.gameHighScore = 0,
  });

  final DinoType dinoType;
  final void Function()? onTapCallback;
  final int gameHighScore;

  @override
  Widget build(BuildContext context) {
    var isUnlocked = gameHighScore >= dinoType.data.$3;

    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: GestureDetector(
        onTap: isUnlocked ? onTapCallback : null,
        child: Column(
          children: [
            isUnlocked
                ? Stack(
                    children: [
                      Image.asset('assets/images/border.png'),
                      Positioned.fill(
                        child: Image.asset(dinoType.data.$1),
                      ),
                    ],
                  )
                : Image.asset('assets/images/dino_hidden.png'),
            const Gap(8),
            Center(
              child: Text(
                dinoType.data.$2,
                style: const TextStyle(
                  fontFamily: 'ArcadeClassic',
                  fontSize: 16,
                  letterSpacing: 4,
                  color: Color(0xFF525252),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
