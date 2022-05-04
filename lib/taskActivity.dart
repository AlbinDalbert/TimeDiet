import 'dart:async';
import 'dart:developer';
import 'tasks.dart';
import 'package:flutter/material.dart';

// this class is the class that handles
// the detailed view of a task

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
