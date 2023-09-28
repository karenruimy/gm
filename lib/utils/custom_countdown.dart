import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({super.key});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  int? _endTime;
  Duration _timeRemaining = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadEndTime();
  }

  // Load the end time from shared preferences
  Future<void> _loadEndTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int endTime = prefs.getInt('end_time') ?? 0;
    setState(() {
      _endTime = endTime;
      _calculateTimeRemaining();
    });
    if (_endTime! > 0) {
      _startTimer();
    }
  }

  // Save the end time to shared preferences
  Future<void> _saveEndTime(int endTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('end_time', endTime);
  }

  // Calculate the remaining time
  void _calculateTimeRemaining() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (_endTime! > now) {
      _timeRemaining = Duration(milliseconds: _endTime! - now);
    } else {
      _timeRemaining = Duration.zero;
    }
  }

  // Start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _calculateTimeRemaining();
        if (_timeRemaining == Duration.zero) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_timeRemaining.inMinutes}:${(_timeRemaining.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 36),
            ),
            ElevatedButton(
              onPressed: () {
                int now = DateTime.now().millisecondsSinceEpoch;
                int endTime =
                    now + (2 * 60 * 1000); // 2 minutes in milliseconds
                _saveEndTime(endTime);
                setState(() {
                  _endTime = endTime;
                  _timeRemaining = const Duration(minutes: 2);
                });
                _startTimer();
              },
              child: const Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
