import 'dart:async';
import 'dart:developer';
import 'tasks.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Todo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              //TODO open drawer here
            },
          ),
        ),
        body: Container(
          child: Column(children: [
            Progress(),
            TaskList(),
          ]),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 112, 205, 255),
                Color.fromARGB(255, 77, 42, 218),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO open add task dialog
            //showDialog(context: context, builder: const Text("data"));

            showDialog(context: context, builder: (_) => const AddTaskDialog());
          },
          child: const Icon(Icons.add),
        ));
  }
}

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task name',
                hintText: 'Enter task name'),
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task description',
                hintText: 'Enter task description'),
          ),
          TimePickerDialog(
            //context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input,
            confirmText: "CONFIRM",
            cancelText: "NOT NOW",
            helpText: "BOOKING TIME",
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              //TODO add task
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ]),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: 520,
      ),
    );
  }

  void show(BuildContext context) {}
}

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  //Progress();

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  //_ProgressState();
  // _progress should be in range [0, 1] and is equal to the number of tasks completed divided by the total number of tasks.

  static const _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    // TODO make values configurable my user
    /*
    var _barColor = _progress < 0.7
        ? Colors.amber
        : _progress < 0.9
            ? Colors.greenAccent
            : Colors.green;
*/
    ColorSwatch<int> _barColor;
    if (_progress == 1) {
      _barColor = Colors.green;
    } else {
      _barColor = Colors.orangeAccent;
    }
    return Container(
      margin: const EdgeInsets.all(21),
      child: Column(
        children: [
          const Text("Progress", style: TextStyle(fontSize: 21)),
          LinearProgressIndicator(
            value: _progress,
            minHeight: 30,
            backgroundColor: Colors.grey,
            color: _barColor,
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  get tasks => null;

  //TaskList();
  int completed() {
    var completed = 0;
    for (var task in tasks) {
      if (task.completed) completed++;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // add all tasks in the list here
        TaskListItem(label: "Task 1"),
        TaskListItem(label: "Task 2"),
        TaskListItem(label: "Task 3"),
      ],
    );
  }
}

class TaskListItem extends StatefulWidget {
  final String label;

  const TaskListItem({Key? key, required this.label}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskListItem> {
  bool _isChecked = false;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            onChanged: (newValue) => setState(() {
              _isChecked = newValue!;
              _done = !_done;
            }),
            value: _isChecked,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.label, style: const TextStyle(fontSize: 26)),
                const Text("35:00", style: TextStyle(fontSize: 21)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border:
            const Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        //color: _done ? Colors.green[400] : Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _done
              ? [Colors.green, Colors.greenAccent]
              : [Colors.white, Colors.white],
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      height: 112,
      duration: const Duration(milliseconds: 200),
    );
  }
}
