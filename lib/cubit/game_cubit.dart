import 'package:bloc/bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.firstLevel());

  void nextLevel() {
    final currentLevel = state.level;
    late final GameState nextLevelState;
    switch (currentLevel) {
      case 1:
        nextLevelState = GameState.secondLevel();
        break;
      case 2:
        nextLevelState = GameState.thirdLevel();
        break;
      case 3:
        nextLevelState = GameState.firstLevel();
        break;

      default:
        nextLevelState = GameState.firstLevel();
        break;
    }

    emit(nextLevelState);
  }

  void restartLevel() {
    final currentLevel = state.level;
    late final GameState newLevelState;
    switch (currentLevel) {
      case 1:
        newLevelState = GameState.firstLevel();
        break;
      case 2:
        newLevelState = GameState.secondLevel();
        break;
      case 3:
        newLevelState = GameState.thirdLevel();
        break;

      default:
        newLevelState = GameState.firstLevel();
        break;
    }

    emit(newLevelState);
  }

  static const _nexPlitkaState = {
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 1,
  };

  void onPlitkaItemTap(int index) {
    final plitkaValue = state.plitkaList[index];
    final plitkaNextValue = _nexPlitkaState[plitkaValue] ?? 1;

    final newPlitkaList = state.plitkaList.toList()
      ..removeAt(index)
      ..insert(index, plitkaNextValue);

    emit(state.copyWith(plitkaList: newPlitkaList));
  }
}
