import 'dart:async';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:todo_list/taskActivity.dart';
import 'package:numberpicker/numberpicker.dart';
import 'tasks.dart';
import 'package:flutter/material.dart';

TaskList taskList = TaskList();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'FiraCode',
      ),
      title: 'Todo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
            const Progress(),
            TaskListView(),
          ]),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 112, 160, 255),
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

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  int _currentMinutes = 10;

  @override
  Widget build(BuildContext context) {
    final taskNameController = TextEditingController();
    final taskDescriptionController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter task name'),
            ),
            TextField(
              //onSubmitted: (value) => _name = value,
              controller: taskDescriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter task description'),
            ),
            NumberPicker(
              value: _currentMinutes,
              minValue: 5,
              step: 5,
              maxValue: 240,
              onChanged: (value) => setState(() => _currentMinutes = value),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('$_currentMinutes min',
                  style: Theme.of(context).textTheme.headline6),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //TODO add task
                taskList.add(Task(taskNameController.text,
                    taskDescriptionController.text, _currentMinutes));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: 520,
      ),
    );
  }
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

  static const _progress = 0.4;

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
    Color _barColor;
    if (_progress == 1) {
      _barColor = Colors.green;
    } else {
      _barColor = Colors.white24;
    }
    return Container(
      margin: const EdgeInsets.all(21),
      child: Column(
        children: [
          const Text("Progress", style: TextStyle(fontSize: 21)),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 8),
                left: BorderSide(color: Colors.white12, width: 8),
              ),
            ),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 30,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(_barColor),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  //final TaskList _tasks = TaskList();
  //TaskList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: taskList.getLength(),
      itemBuilder: (context, index) {
        //return Text('data');
        return TaskListItem(index: index);
      },
      /*
      children: const [
        // add all tasks in the list here
        Text('hello'),
        TaskListItem(label: "Task 1"),
        TaskListItem(label: "Task 2"),
        TaskListItem(label: "Task 3"),
      ],*/
    ));
  }
}

class TaskListItem extends StatefulWidget {
  //final String label;
  final int index;
  const TaskListItem({Key? key, required this.index}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState(index);
}

class _TaskItemState extends State<TaskListItem> {
  bool _isChecked = false;
  bool _done = false;

  int index;

  _TaskItemState(this.index);

  @override
  Widget build(BuildContext context) {
    Task task = taskList.getTask(index);
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
                Text(task.name, style: const TextStyle(fontSize: 26)),
                Text(task.getTimeString, style: const TextStyle(fontSize: 21)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
      //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 12),
          //top: BorderSide(color: Colors.white12, width: 4),
        ),
        //color: _done ? Colors.green[400] : Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _done
              ? [Colors.white38, Colors.white38]
              : [Colors.white, Colors.white],
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      height: 112,
      duration: const Duration(milliseconds: 200),
    );
  }
}
