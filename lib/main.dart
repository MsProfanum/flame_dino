import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_dino/flame_dino_game.dart';
import 'package:flame_dino/overlays/chosen_dino/choose_dino_overlay.dart';
import 'package:flame_dino/overlays/chosen_dino/cubit/chosen_dino_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChosenDinoCubit>(
          create: (_) => ChosenDinoCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FlameDinoGame(
        chosenDinoCubit: context.read<ChosenDinoCubit>(),
      ),
      overlayBuilderMap: {
        'choose_dino': (context, game) => ChooseDinoOverlay(
              game: game as FlameDinoGame,
            ),
      },
    );
  }
}
