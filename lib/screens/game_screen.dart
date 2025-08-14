// lib/screens/game_screen.dart
import 'dart:math' as math;

import 'package:badges/badges.dart' as badges;
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

class _GameScreenState extends ConsumerState<GameScreen>
    with TickerProviderStateMixin {
  final Map<(int, int), GlobalKey> _tileKeys = {};
  OverlayEntry? _thunderOverlay;
  OverlayEntry? _blastOverlay1;
  OverlayEntry? _blastOverlay2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameProvider.notifier).startLevel(widget.level);
    });
  }

  void _showMatchAnimation((int, int) p1, (int, int) p2) {
    final key1 = _tileKeys[p1];
    final key2 = _tileKeys[p2];
    if (key1 == null || key2 == null) return;

    final render1 = key1.currentContext?.findRenderObject() as RenderBox?;
    final render2 = key2.currentContext?.findRenderObject() as RenderBox?;
    if (render1 == null || render2 == null) return;

    final pos1 = render1.localToGlobal(Offset.zero) +
        Offset(render1.size.width / 2, render1.size.height / 2);
    final pos2 = render2.localToGlobal(Offset.zero) +
        Offset(render2.size.width / 2, render2.size.height / 2);

    _thunderOverlay = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        top: 0,
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: ThunderPainter(pos1, pos2),
        ),
      );
    });
    Overlay.of(context).insert(_thunderOverlay!);

    // Blast at pos1
    final controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    controller1.forward();
    _blastOverlay1 = OverlayEntry(builder: (context) {
      return Positioned(
        left: pos1.dx - 25,
        top: pos1.dy - 25,
        child: ScaleTransition(
          scale: Tween(begin: 0.5, end: 2.0).animate(controller1),
          child: FadeTransition(
            opacity: Tween(begin: 1.0, end: 0.0).animate(controller1),
            child: const Icon(Icons.star, color: Colors.yellow, size: 50),
          ),
        ),
      );
    });
    Overlay.of(context).insert(_blastOverlay1!);

    // Blast at pos2
    final controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    controller2.forward();
    _blastOverlay2 = OverlayEntry(builder: (context) {
      return Positioned(
        left: pos2.dx - 25,
        top: pos2.dy - 25,
        child: ScaleTransition(
          scale: Tween(begin: 0.5, end: 2.0).animate(controller2),
          child: FadeTransition(
            opacity: Tween(begin: 1.0, end: 0.0).animate(controller2),
            child: const Icon(Icons.star, color: Colors.yellow, size: 50),
          ),
        ),
      );
    });
    Overlay.of(context).insert(_blastOverlay2!);

    Future.delayed(const Duration(milliseconds: 500), () {
      _thunderOverlay?.remove();
      _thunderOverlay = null;
      _blastOverlay1?.remove();
      _blastOverlay1 = null;
      _blastOverlay2?.remove();
      _blastOverlay2 = null;
      controller1.dispose();
      controller2.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    ref.listen(gameProvider, (prev, next) {
      if (next.faded.length > (prev?.faded.length ?? 0)) {
        final newFaded = next.faded.difference(prev?.faded ?? {});
        if (newFaded.length == 2) {
          final p1 = newFaded.first;
          final p2 = newFaded.last;
          _showMatchAnimation(p1, p2);
          Future.delayed(const Duration(milliseconds: 500), () {
            ref.read(gameProvider.notifier).state = next.copyWith(
              grid: _removeMatched(next.grid, p1, p2),
              faded: {...next.faded}
                ..remove(p1)
                ..remove(p2),
            );
          });
        }
      }
    });

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
                    IconButton(
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.yellow),
                        onPressed: () => Navigator.pop(context)),
                    Text(widget.level.toString(),
                        style: const TextStyle(
                            fontSize: 40, color: Colors.yellow)),
                    IconButton(
                        icon: const Icon(Icons.settings, color: Colors.yellow),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()))),
                  ],
                ),
                Text('Stage ${widget.stage}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                      childAspectRatio: 1,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: 9 * 20,
                    itemBuilder: (context, index) {
                      final row = index ~/ 9;
                      final col = index % 9;
                      if (row >= gameState.grid.length) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple[200]!)),
                          child: Center(
                              child: Icon(Icons.circle,
                                  color: Colors.accents[math.Random()
                                      .nextInt(Colors.accents.length)],
                                  size: 5)),
                        );
                      }
                      final num = gameState.grid[row][col];
                      if (num == 0)
                        return Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple[200]!)));
                      final key = GlobalKey();
                      _tileKeys[(row, col)] = key;
                      final isSelected = gameState.selected == (row, col);
                      final isHinted = gameState.hinted.contains((row, col));
                      return NumberTile(
                        key: key,
                        number: num,
                        isSelected: isSelected,
                        isHinted: isHinted,
                        onTap: () =>
                            ref.read(gameProvider.notifier).tapCell(row, col),
                      );
                    },
                  ),
                ),
                if (gameState.noMorePairs)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'No more pairs. Tap the plus icon to add more numbers.',
                        style: TextStyle(color: Colors.white)),
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

  List<List<int>> _removeMatched(
      List<List<int>> grid, (int, int) p1, (int, int) p2) {
    final newGrid = grid.map((row) => row.toList()).toList();
    final (r1, c1) = p1;
    final (r2, c2) = p2;
    newGrid[r1][c1] = 0;
    newGrid[r2][c2] = 0;
    return newGrid;
  }
}

class ThunderPainter extends CustomPainter {
  final Offset pos1;
  final Offset pos2;

  ThunderPainter(this.pos1, this.pos2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw zigzag for thunder
    final dx = pos2.dx - pos1.dx;
    final dy = pos2.dy - pos1.dy;
    final segments = 10;
    final path = Path()..moveTo(pos1.dx, pos1.dy);
    for (int i = 1; i <= segments; i++) {
      final t = i / segments;
      final x = pos1.dx + dx * t + (math.Random().nextDouble() - 0.5) * 20;
      final y = pos1.dy + dy * t + (math.Random().nextDouble() - 0.5) * 20;
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
