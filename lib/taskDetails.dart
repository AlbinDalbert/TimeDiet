import 'dart:async';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'tasks.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskDetailsView extends StatefulWidget {
  final Task task;
  const TaskDetailsView({Key? key, required this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskDetailsView(task);
}

class _TaskDetailsView extends State<TaskDetailsView> {
  Task task;
  double taskProgress = 0.0;
  String strTimeLeft = "00:00:00";
  String strTimeBeen = "00:00:00";
  String buttonText = "Start";

  SnoozeTimer snoozeTimer = SnoozeTimer(300);
  String strSnoozeTime = "00:00:00";
  bool snooze = false;

  final audioPlayer = AudioCache();

  _TaskDetailsView(this.task) {
    taskProgress = 1.0 - task.getProgress;
    strTimeLeft = task.getTimeString;
    strTimeBeen = task.getTimeStringRun;
    audioPlayer.load("TimerRunningSmall.mp3");
  }

  updateTimer(int timeLeft) {
    if (task.isRunning) {
      //audioPlayer.play('TimerRunningSmall.mp3');
    }

    setState(() {
      //taskProgress = 1.0 - (timeLeft / task.getTotalTime);
      strTimeLeft = task.getTimeString;
      strTimeBeen = task.getTimeStringRun;
      if (task.isRunning) {
        buttonText = "Snooze";
      } else if (task.getStoredProgress > 0.0) {
        buttonText = "Resume";
      }
      if (timeLeft == 0) {
        buttonText = "Done";
      }

      if (snooze) {
        if (!snoozeTimer.isRunning) {
          snoozeTimer = SnoozeTimer(0);
          snoozeTimer.start();
        }
        strSnoozeTime = snoozeTimer.getTimeString;
      } else {
        if (snoozeTimer.isRunning) {
          snoozeTimer.stop();
        }
        strSnoozeTime = "🔥🔥🔥";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    task.setUpdateTimer(updateTimer);
    snoozeTimer.setUpdateTimer(updateTimer);
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text(task.getName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (task.isRunning) {
              task.stopTask();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          child: Column(children: [
            AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    key: UniqueKey(),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(30),
                    //padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: CircularPercentIndicator(
                      key: UniqueKey(),
                      radius: 140,
                      progressColor: Colors.indigo,
                      backgroundColor: Colors.white38,
                      animation: false,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: (() {
                        if (snooze) {
                          return Column(children: [
                            Text(strTimeBeen,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.black)),
                            Text(strSnoozeTime,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 165, 0, 0)))

                            /*
                            return Text(strSnoozeTime,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.black));*/
                          ], mainAxisAlignment: MainAxisAlignment.center);
                        } else {
                          return Column(children: [
                            Text(strTimeBeen,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.black)),

                            /*
                            return Text(strSnoozeTime,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.black));*/
                          ], mainAxisAlignment: MainAxisAlignment.center);
                        }
                      })(),
                      percent: (() {
                        if (task == null) {
                          return 0.0;
                        }
                        if (task.isRunning) {
                          return 1.0 - task.getProgress;
                        } else {
                          return 1.0 - task.getStoredProgress;
                        }
                      }()),
                      lineWidth: 30.0,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 8),
                        left: BorderSide(color: Colors.black12, width: 8),
                        right: BorderSide(color: Colors.white12, width: 8),
                        top: BorderSide(color: Colors.white24, width: 8),
                      ),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(40),
                        child: Text(task.getName,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))),
                    Flexible(
                        child: Column(
                      children: [
                        Text(task.getDescription,
                            style: const TextStyle(fontSize: 20)),
                        Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.1),
                              ),
                              child: Text(buttonText),
                              onPressed: () {
                                if (task.isRunning) {
                                  snooze = true;
                                  task.stopTask();
                                } else {
                                  snooze = false;
                                  task.startTask();
                                }
                              }),
                          margin: const EdgeInsets.all(40),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )),
                  ],
                ),
                decoration: const BoxDecoration(
                    //color: Color.fromARGB(255, 157, 175, 212),
                    color: Colors.white38,
                    border: Border(
                        //bottom: BorderSide(color: Colors.black26, width: 8),
                        //left: BorderSide(color: Colors.black12, width: 8),
                        //right: BorderSide(color: Colors.white12, width: 8),
                        //top: BorderSide(color: Colors.white, width: 8),
                        ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ))),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 112, 160, 255), Colors.indigo],
            ),
          ),
          alignment: Alignment.center),
    );
  }
}

class SnoozeTimer {
  Function _onTick = () {};
  int _timeLeft;

  bool _isRunning = false;
  final audioPlayer = AudioCache();
  SnoozeTimer(this._timeLeft) {
    audioPlayer.load('NoMoreSnooze.mp3');
  }

  start() {
    _isRunning = true;
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _timeLeft++;
      // every 5 min (300 sec) play a sound to remind the user
      if (_timeLeft % 300 == 0 && _timeLeft != 0) {
        audioPlayer.play('NoMoreSnooze.mp3');
      }
      if (!_isRunning) {
        t.cancel();
      }
      _onTick(_timeLeft);
    });
  }

  stop() {
    _isRunning = false;
  }

  setUpdateTimer(Function f) {
    _onTick = f;
  }

  get isRunning => _isRunning;

  int getTimeLeft() {
    return _timeLeft;
  }

  String get getTimeString {
    int hours = _timeLeft ~/ 3600;
    int minutes = (_timeLeft ~/ 60) % 60;
    int seconds = _timeLeft % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
