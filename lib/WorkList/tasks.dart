// ignore_for_file: unnecessary_this

import 'dart:async';

class Task {
  String name;
  String description;
  int totalTime;
  final Function updateTimer;
  int _timeLeftSec = 0;
  TaskTimer _timer = TaskTimer(0, () {});
  Task(
    this.name,
    this.description,
    this.totalTime,
    this.updateTimer,
  ) {
    _timeLeftSec = totalTime * 60;
    _timer = TaskTimer(_timeLeftSec, updateTimer);
    //_timer.setTimeLeft(_timeLeftSec);
  }

  setUpdateTimer(Function updateTimer) {
    _timer.setUpdateTimer(updateTimer);
  }

  get getName => name;
  get getDescription => description;
  int get getTotalTime => totalTime;
  //int get getTimeLeft => _timeLeftSec;

  get getProgress => _timer.getLiveProgress;

  String get getTimeString {
    return _timer.getTimeString;
  }

  String get getTimeStringRun {
    return _timer.getTimeStringRun;
  }

  get isRunning => _timer.isRunning;
  get getStoredProgress => _timer.getStoredProgress;

  startTask() {
    _timeLeftSec = totalTime;
    // TODO start the task timer
    // on other thread
    _timer.startTimer();
  }

  stopTask() {
    _timer.stopTimer();
  }

  bool isCompleted() {
    return _timeLeftSec == 0;
  }
}

class TaskTimer {
  Function _onTick;
  final int _totalTime;
  int _timeLeftSec = 0;
  int workingTime = 0;

  TaskTimer(this._totalTime, this._onTick) {
    _timeLeftSec = _totalTime;
  }
  bool running = false;

  setTimeLeft(int timeLeft) {
    _timeLeftSec = timeLeft;
  }

  //start timer
  startTimer() {
    workingTime = _timeLeftSec;

    running = true;
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (workingTime > 0) {
        workingTime--;
        _timeLeftSec = workingTime;
      } else {
        //workingTime--;
        //_timeLeftSec = workingTime;
        t.cancel();
      }
      _onTick(_timeLeftSec);
    });
  }

  // cancel timer
  stopTimer() {
    _timeLeftSec = workingTime;
    workingTime = 0;
    running = false;
  }

  String get getTimeString {
    int hours = _timeLeftSec ~/ 3600;
    int minutes = (_timeLeftSec ~/ 60) % 60;
    int seconds = _timeLeftSec % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get getTimeStringRun {
    int timeBeen = _totalTime - _timeLeftSec;
    int hours = timeBeen ~/ 3600;
    int minutes = (timeBeen ~/ 60) % 60;
    int seconds = timeBeen % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  get isRunning => running;

  get getLiveProgress => workingTime / _totalTime;
  get getStoredProgress => _timeLeftSec / _totalTime;
  // get time left
  get getTimeLeft => _timeLeftSec;
  get getWorkingTime => workingTime;

  void setUpdateTimer(Function updateTimer) {
    _onTick = updateTimer;
  }
}

class TaskList {
  List<Task> taskList = <Task>[];
  int rawTotalTime = 0;
  int rawCompletedTime = 0;
/*
  tasks() {
    //TODO add tasks from database

    // calculate raw total time
    for (var task in taskList) {
      rawTotalTime += task.getTotalTime;
    }
  }
*/
  bool isEmpty() {
    return taskList.isEmpty;
  }

  add(Task task) {
    taskList.add(task);
    rawTotalTime += task.getTotalTime;
  }

  Task getTask(int index) {
    return taskList[index];
  }

  remove(int index) {
    rawTotalTime -= taskList[index].getTotalTime;
    taskList.removeAt(index);
  }

  removeTask(Task task) {
    rawTotalTime -= task.getTotalTime;
    taskList.remove(task);
  }

  // return percentage of completed time
  getCompletedPercentage() {
    if (rawTotalTime == 0) {
      return 1.0;
    }
    if (rawCompletedTime == 0) {
      return 0.0;
    }
    return rawCompletedTime / rawTotalTime;
  }

  get getTasks => taskList;

  int getLength() {
    return taskList.length;
  }

  getTaskLength() {}
}

class Time {
  int minutes;
  int seconds;
  Time(this.minutes, this.seconds);

  @override
  String toString() {
    return '$minutes:$seconds';
  }

  int toRaw() {
    return minutes * 60 + seconds;
  }

  int get rawTime => (minutes * 60) + this.seconds;
}
