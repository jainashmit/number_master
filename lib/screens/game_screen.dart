// import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_master/providers/game_provider.dart';
import 'package:number_master/screens/settings_screen.dart';
import 'package:number_master/widgets/number_tile.dart';
import 'package:number_master/widgets/custom_button.dart';

class GameScreen extends ConsumerStatefulWidget {
  final int level;
  final int stage;

  const GameScreen({super.key, required this.level, required this.stage});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(gameProvider.notifier).startLevel(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: Colors.yellow), onPressed: () => Navigator.pop(context)),
                    Text(widget.level.toString(), style: const TextStyle(fontSize: 40, color: Colors.yellow)),
                    IconButton(icon: const Icon(Icons.settings, color: Colors.yellow), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()))),
                  ],
                ),
                Text('Stage ${widget.stage}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                      childAspectRatio: 1,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: 9 * 20, // Max 20 rows for scroll
                    itemBuilder: (context, index) {
                      final row = index ~/ 9;
                      final col = index % 9;
                      if (row >= gameState.grid.length) {
                        return Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.purple[200]!)),
                          child: Center(child: Icon(Icons.circle, color: Colors.pink[200], size: 5)), // Small dots
                        );
                      }
                      final num = gameState.grid[row][col];
                      final isFaded = gameState.faded.contains((row, col));
                      final isSelected = gameState.selected == (row, col);
                      final isHinted = gameState.hinted.contains((row, col));
                      return NumberTile(
                        number: num,
                        isFaded: isFaded,
                        isSelected: isSelected,
                        isHinted: isHinted,
                        onTap: () => ref.read(gameProvider.notifier).tapCell(row, col),
                      );
                    },
                  ),
                ),
                if (gameState.noMorePairs)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No more pairs. Tap the plus icon to add more numbers.', style: TextStyle(color: Colors.white)),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      icon: Icons.add,
                      badge: gameState.addsLeft,
                      onPressed: () => ref.read(gameProvider.notifier).addRow(),
                    ),
                    CustomButton(
                      icon: Icons.lightbulb,
                      badge: gameState.hintsLeft,
                      onPressed: () => ref.read(gameProvider.notifier).hint(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}