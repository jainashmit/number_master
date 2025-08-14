// lib/providers/game_provider.dart
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_master/models/game_state.dart';

final gameProvider =
    StateNotifierProvider<GameNotifier, GameState>((ref) => GameNotifier());

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.initial());

  void startLevel(int level) {
    final rows = 3 + (level - 1); // Increase difficulty
    final cols = 9;
    final grid = List.generate(
      rows,
      (_) => List.generate(cols, (_) => math.Random().nextInt(9) + 1),
    );
    state = GameState(
      grid: grid,
      faded: {},
      addsLeft: 5 + level, // More adds for higher levels
      hintsLeft: 3,
    );
    _checkNoMorePairs();
  }

  void tapCell(int row, int col) {
    if (state.grid[row][col] == 0) return; // Empty

    if (state.selected == null) {
      state = state.copyWith(selected: (row, col));
    } else {
      final (sRow, sCol) = state.selected!;
      if (sRow == row && sCol == col) {
        state = state.copyWith(selected: null);
        return;
      }
      if (isValidPair(sRow, sCol, row, col)) {
        state = state.copyWith(
          faded: {...state.faded, (sRow, sCol), (row, col)},
          selected: null,
        );
        _checkNoMorePairs();
        if (isLevelComplete()) {
          // Level complete logic
        }
      } else {
        state = state.copyWith(selected: null);
      }
    }
  }

  bool isValidPair(int r1, int c1, int r2, int c2) {
    final v1 = state.grid[r1][c1];
    final v2 = state.grid[r2][c2];
    if (v1 == 0 || v2 == 0) return false;
    if (v1 != v2 && v1 + v2 != 10) return false;
    if (r1 == r2) {
      final minC = math.min(c1, c2);
      final maxC = math.max(c1, c2);
      for (int c = minC + 1; c < maxC; c++) {
        if (state.grid[r1][c] != 0) return false; // Not empty
      }
      return true;
    } else if (c1 == c2) {
      final minR = math.min(r1, r2);
      final maxR = math.max(r1, r2);
      for (int r = minR + 1; r < maxR; r++) {
        if (state.grid[r][c1] != 0) return false;
      }
      return true;
    }
    return false;
  }

  bool isLevelComplete() {
    final total =
        state.grid.fold(0, (sum, row) => sum + row.where((n) => n != 0).length);
    return total == 0;
  }

  void addRow() {
    if (state.addsLeft > 0) {
      final newRow = List.generate(9, (_) => math.Random().nextInt(9) + 1);
      state = state.copyWith(
        grid: [...state.grid, newRow],
        addsLeft: state.addsLeft - 1,
      );
      _checkNoMorePairs();
    }
  }

  void hint() {
    if (state.hintsLeft > 0) {
      final pair = _findPair();
      if (pair != null) {
        final (p1, p2) = pair;
        state =
            state.copyWith(hinted: {p1, p2}, hintsLeft: state.hintsLeft - 1);
        Future.delayed(const Duration(seconds: 3), () {
          state = state.copyWith(hinted: {});
        });
      }
    }
  }

  ((int, int), (int, int))? _findPair() {
    for (int r1 = 0; r1 < state.grid.length; r1++) {
      for (int c1 = 0; c1 < 9; c1++) {
        if (state.grid[r1][c1] == 0) continue;
        for (int r2 = 0; r2 < state.grid.length; r2++) {
          for (int c2 = 0; c2 < 9; c2++) {
            if ((r1 == r2 && c1 == c2) || state.grid[r2][c2] == 0) continue;
            if (isValidPair(r1, c1, r2, c2)) return ((r1, c1), (r2, c2));
          }
        }
      }
    }
    return null;
  }

  void checkNoMorePairs() => _checkNoMorePairs();
  void _checkNoMorePairs() {
    state = state.copyWith(noMorePairs: _findPair() == null);
  }
}
