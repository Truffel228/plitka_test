import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_plitka/screens/main_screen/cubit/game_cubit.dart';
import 'package:test_plitka/screens/main_screen/widgets/footer.dart';
import 'package:test_plitka/screens/main_screen/widgets/plitka_grid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _cubit = GameCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        bloc: _cubit,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/header_background.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned.fill(
                      bottom: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: _cubit.nextLevel,
                          child: const Text(
                            'Next Level',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: PlitkaGrid(
                    dimension: state.dimension,
                    plitkaList: state.plitkaList,
                    onPlitkaItemTap: _cubit.onPlitkaItemTap,
                  ),
                ),
              ),
              Expanded(
                child: Footer(
                  gameUntil: state.gameUntil,
                  onRestartTap: _cubit.restartLevel,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
