import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  Time startTime;
  Time timeLeft;
  String status;
  Task(this.name, this.description, this.startTime, this.timeLeft, this.status);
}

class Tasks {
  List<Task> tasks = [];
  Tasks() {
    tasks.add(Task(
        'Task 1', 'Description 1', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 2', 'Description 2', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 3', 'Description 3', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 4', 'Description 4', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 5', 'Description 5', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 6', 'Description 6', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 7', 'Description 7', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 8', 'Description 8', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 9', 'Description 9', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 10', 'Description 10', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 11', 'Description 11', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 12', 'Description 12', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 13', 'Description 13', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 14', 'Description 14', Time(10, 0), Time(10, 0), 'In Progress'));
    tasks.add(Task(
        'Task 15', 'Description 15', Time(10, 0), Time(10, 0), 'In Progress'));
  }
}

class Time {
  int hours;
  int minutes;
  Time(this.hours, this.minutes);

  @override
  String toString() {
    return '$hours:$minutes';
  }
}
