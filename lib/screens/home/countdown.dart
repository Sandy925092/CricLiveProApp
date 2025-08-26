import 'dart:async';
import 'package:flutter/material.dart';

class MatchCountdown extends StatefulWidget {
  final DateTime startDate;
  final TextStyle? style;

  const MatchCountdown({Key? key, required this.startDate, this.style})
      : super(key: key);

  @override
  _MatchCountdownState createState() => _MatchCountdownState();
}

class _MatchCountdownState extends State<MatchCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemaining();
    });
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.startDate.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining.isNegative) {
      return Text("Started", style: widget.style);
    }

    if (_remaining.inHours >= 24) {
      return Text(
        "${_remaining.inDays} day${_remaining.inDays > 1 ? "s" : ""} left",
        style: widget.style,
      );
    } else {
      final hours = _remaining.inHours.toString().padLeft(2, '0');
      final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

      return Column(
        children: [
          Text("Starting in", style: widget.style),
          Text("$hours:$minutes:$seconds hrs", style: widget.style),
        ],
      );
    }
  }
}
