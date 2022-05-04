// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  int totalTime;
  int _timeLeft = 0;
  String status;
  Task(this.name, this.description, this.totalTime, this.status) {
    int _timeLeft = totalTime;
  }

  get getName => name;
  get getDescription => description;
  int get getTotalTime => totalTime;
  get getStatus => status;

  startTask() {
    _timeLeft = totalTime;
    status = 'started';
    // TODO start the task timer
    // on other thread
  }
}

class Tasks {
  List<Task> tasks = [];
  int rawTotalTime = 0;
  int rawCompletedTime = 0;
  Tasks() {
    //TODO add tasks from database

    // temp tasks
    tasks.add(Task("Task 1", "Description 1", 6000, "In Progress"));
    tasks.add(Task("Task 2", "Description 2", 6000, "In Progress"));
    tasks.add(Task("Task 3", "Description 3", 6000, "In Progress"));

    // calculate raw total time
    for (var task in tasks) {
      rawTotalTime += task.getTotalTime;
    }
  }

  get getTasks => tasks;
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
