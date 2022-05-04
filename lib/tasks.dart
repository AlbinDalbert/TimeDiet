// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  int totalTime;
  int _timeLeftSec = 0;
  Task(this.name, this.description, this.totalTime) {
    _timeLeftSec = totalTime * 60;
  }

  get getName => name;
  get getDescription => description;
  int get getTotalTime => totalTime;
  //int get getTimeLeft => _timeLeft;

  get getTimeString {
    int hours = _timeLeftSec ~/ 3600;
    int minutes = _timeLeftSec ~/ 60 % 60;
    int seconds = _timeLeftSec % 60;

    return '0$hours:' +
        (minutes < 10
            ? '0$minutes'
            : '$minutes' ':' + (seconds < 10 ? '0$seconds' : '$seconds'));
//    String timeString =
    //      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    // return timeString;
  }

  startTask() {
    _timeLeftSec = totalTime;
    // TODO start the task timer
    // on other thread
  }
}

class TaskList {
  List<Task> taskList = <Task>[];
  int rawTotalTime = 0;
  int rawCompletedTime = 0;
  Tasks() {
    //TODO add tasks from database

    // calculate raw total time
    for (var task in taskList) {
      rawTotalTime += task.getTotalTime;
    }
  }

  add(Task task) {
    taskList.add(task);
    rawTotalTime += task.getTotalTime;
  }

  Task getTask(int index) {
    return taskList[index];
  }

  get getTasks => taskList;

  int getLength() {
    return taskList.length;
  }
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
