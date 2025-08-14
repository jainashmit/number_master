// lib/models/game_state.dart
import 'package:equatable/equatable.dart';

class GameState extends Equatable {
  final List<List<int>> grid;
  final Set<(int, int)> faded;
  final (int, int)? selected;
  final Set<(int, int)> hinted;
  final int addsLeft;
  final int hintsLeft;
  final bool noMorePairs;

  const GameState({
    required this.grid,
    required this.faded,
    this.selected,
    this.hinted = const {},
    required this.addsLeft,
    required this.hintsLeft,
    this.noMorePairs = false,
  });

  factory GameState.initial() => const GameState(
        grid: [],
        faded: {},
        addsLeft: 0,
        hintsLeft: 0,
      );

  GameState copyWith({
    List<List<int>>? grid,
    Set<(int, int)>? faded,
    (int, int)? selected,
    Set<(int, int)>? hinted,
    int? addsLeft,
    int? hintsLeft,
    bool? noMorePairs,
  }) {
    return GameState(
      grid: grid ?? this.grid,
      faded: faded ?? this.faded,
      selected: selected ?? this.selected,
      hinted: hinted ?? this.hinted,
      addsLeft: addsLeft ?? this.addsLeft,
      hintsLeft: hintsLeft ?? this.hintsLeft,
      noMorePairs: noMorePairs ?? this.noMorePairs,
    );
  }

  @override
  List<Object?> get props => [grid, faded, selected, hinted, addsLeft, hintsLeft, noMorePairs];
}