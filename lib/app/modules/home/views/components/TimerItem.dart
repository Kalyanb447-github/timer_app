import 'package:flutter/material.dart';
import 'package:timer_app/app/modules/home/controllers/home_controller.dart';

class TimerItem extends StatefulWidget {
  final int minutes;
  final int seconds;
  final int index;

  const TimerItem(
      {required this.minutes, required this.seconds, required this.index});

  @override
  _TimerItemState createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  late int remainingMinutes;
  late int remainingSeconds;
  late bool isRunning;

  @override
  void initState() {
    super.initState();
    remainingMinutes = widget.minutes;
    remainingSeconds = widget.seconds;
    isRunning = true;
    _startTimer();
  }

  void _startTimer() {
    if (isRunning) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            if (remainingMinutes > 0) {
              remainingMinutes--;
              remainingSeconds = 59;
            } else {
              isRunning = false;
            }
          }
        });
        _startTimer();
      });
    } else if (remainingMinutes == 0 && remainingSeconds == 0) {
      // HomeController.to.removeTimer(widget.index);
    }
  }

  void _toggleTimer() {
    setState(() {
      isRunning = !isRunning;
      if (isRunning) {
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color timerColor = Colors.green;
    if (!isRunning) {
      timerColor = Colors.yellow;
    } else if (remainingMinutes == 0 && remainingSeconds <= 30) {
      timerColor = Colors.red;
    }

    return Card(
      color: timerColor,
      child: ListTile(
        title: Text(
          '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
          onPressed: _toggleTimer,
        ),
        onTap: () => _toggleTimer(),
        // onLongPress: () => _removeTimer(),
      ),
    );
  }
}
