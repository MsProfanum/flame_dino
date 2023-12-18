import 'package:bloc/bloc.dart';
import 'package:flame_dino/overlays/chosen_dino/dino_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chosen_dino_cubit.freezed.dart';
part 'chosen_dino_state.dart';

class ChosenDinoCubit extends Cubit<DinoType> {
  ChosenDinoCubit() : super(DinoType.dinoClassic);

  void changeDino(DinoType dinoType) => emit(dinoType);
}
