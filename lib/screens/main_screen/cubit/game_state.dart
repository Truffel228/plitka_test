part of 'game_cubit.dart';

class GameState {
  const GameState({
    required this.level,
    required this.dimension,
    required this.plitkaList,
    required this.timer,
    required this.gameUntil,
  });

  final int level;
  final int dimension;
  final List<int> plitkaList;
  final Duration timer;
  final DateTime gameUntil;

  factory GameState.firstLevel() {
    const timer = Duration(minutes: 1, seconds: 30);

    return GameState(
      level: 1,
      dimension: 3,
      plitkaList: [1, 1, 1, 1, 1, 1, 1, 1, 1],
      timer: timer,
      gameUntil: DateTime.now().add(timer),
    );
  }

  factory GameState.secondLevel() {
    const timer = Duration(minutes: 2, seconds: 30);
    return GameState(
      level: 2,
      dimension: 4,
      plitkaList: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      timer: timer,
      gameUntil: DateTime.now().add(timer),
    );
  }

  factory GameState.thirdLevel() {
    const timer = Duration(minutes: 3, seconds: 30);
    return GameState(
      level: 3,
      dimension: 5,
      plitkaList: [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
      ],
      timer: timer,
      gameUntil: DateTime.now().add(timer),
    );
  }

  GameState copyWith({
    int? level,
    int? dimension,
    List<int>? plitkaList,
    Duration? timer,
    DateTime? gameUntil,
  }) {
    return GameState(
      level: level ?? this.level,
      dimension: dimension ?? this.dimension,
      plitkaList: plitkaList ?? this.plitkaList,
      timer: timer ?? this.timer,
      gameUntil: gameUntil ?? this.gameUntil,
    );
  }
}
