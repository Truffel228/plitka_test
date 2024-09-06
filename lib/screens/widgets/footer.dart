import 'dart:async';

import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.gameUntil,
    required this.onRestartTap,
  });

  final DateTime gameUntil;
  final VoidCallback onRestartTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/footer_background.png',
          fit: BoxFit.fitWidth,
        ),
        Positioned.fill(
          left: 16,
          right: 16,
          child: Center(
            child: Row(
              children: [
                _TimerButton(gameUntil: gameUntil),
                const SizedBox(width: 24),
                Expanded(
                  child: InkWell(
                    onTap: onRestartTap,
                    child: Image.asset(
                      'assets/button_restart.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerButton extends StatefulWidget {
  const _TimerButton({
    required this.gameUntil,
  });

  final DateTime gameUntil;

  @override
  State<_TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<_TimerButton> {
  late final ValueNotifier<Duration> _remaingTime =
      ValueNotifier(Duration.zero);

  late final Timer _stopwatch;

  @override
  void initState() {
    _setRemainingTime();

    _stopwatch = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _setRemainingTime(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _stopwatch.cancel();
    super.dispose();
  }

  void _setRemainingTime() {
    final now = DateTime.now();

    if (now.isAfter(widget.gameUntil)) {
      _remaingTime.value = Duration.zero;
      return;
    }

    final difference = widget.gameUntil.difference(now);
    _remaingTime.value = difference;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFCC620C),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'timer',
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
          ListenableBuilder(
            listenable: _remaingTime,
            builder: (context, child) {
              return Text(
                _remaingTimeString,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String get _remaingTimeString {
    final minutes = _remaingTime.value.inMinutes.toString().padLeft(2, '0');
    final seconds =
        (_remaingTime.value.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
