//import 'package:numberpicker/numberpicker.dart';
import 'tasks.dart';
import 'taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/background.dart';
//import 'drawer.dart';

TaskList taskList = TaskList();

class WorkList extends StatefulWidget {
  const WorkList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorkList();
}

class _WorkList extends State<WorkList> {
  var progress = taskList.getCompletedPercentage();
  var length = 0;
  var completed = 0;
  //late NavDrawer navDrawer;

  updateList() {
    setState(() {
      progress = taskList.getCompletedPercentage();
      length = taskList.getLength();

      //completed = taskList.getCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    //navDrawer = NavDrawer(context);
    return Scaffold(
      key: UniqueKey(),
      appBar: null,
      body: (() {
        if (taskList.isEmpty()) {
          return Stack(children: [
            mainBackground(),
            const Center(
              child: Text('No tasks todo'),
            )
          ]);
        } else {
          return Stack(children: [
            mainBackground(),
            //Progress(),
            TaskListView(updateList: updateList),
          ]);
        }
      }()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AddTaskDialog(
                    updateList: updateList,
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  final Function updateList;
  const AddTaskDialog({Key? key, required this.updateList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  int _currentMinutes = 25;
  int _numberOfTasks = 1;

  @override
  Widget build(BuildContext context) {
    final taskNameController = TextEditingController();
    final taskDescriptionController = TextEditingController();
    final taskTimeController = TextEditingController();
    final taskNumberOfTasksController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              maxLength: 16,
              controller: taskNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter task name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              //onSubmitted: (value) => _name = value,
              controller: taskDescriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter task description'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: taskTimeController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                  hintText: 'Enter task time minutes'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a time';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: taskNumberOfTasksController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of tasks',
                  hintText: 'Enter number of tasks'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (taskNumberOfTasksController.text == null ||
                    taskNumberOfTasksController.text.isEmpty) {
                  taskNumberOfTasksController.text = '1';
                }
                _numberOfTasks = int.parse(taskNumberOfTasksController.text);
                if (taskTimeController.text == null ||
                    taskTimeController.text.isEmpty) {
                  taskTimeController.text = '15';
                }
                _currentMinutes = int.parse(taskTimeController.text);
                if (taskNameController.text.isNotEmpty) {
                  for (var i = 0; i < _numberOfTasks; i++) {
                    taskList.add(Task(
                        taskNameController.text +
                            " (" +
                            (i + 1).toString() +
                            ("/" + _numberOfTasks.toString() + ")"),
                        taskDescriptionController.text,
                        _currentMinutes,
                        () {}));
                  }
                  Navigator.pop(context);
                  widget.updateList();
                } else {
                  //TODO show error
                }
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
        height: 420,
        //height: MediaQuery.of(context).size.height * 0.5,
        //width: MediaQuery.of(context).size.width * 1,
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
  double _progress = taskList.getCompletedPercentage();
  update() {
    setState(() {
      _progress = taskList.getCompletedPercentage();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _progress = taskList.getCompletedPercentage();
/*
    if (_progress > 1) {
      _progress = 1;
    }*/
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
      key: UniqueKey(),
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
  const TaskListView({Key? key, required this.updateList}) : super(key: key);
  final Function updateList;
  //final TaskList _tasks = TaskList();
  //TaskList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      key: UniqueKey(),
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: taskList.getLength(),
      itemBuilder: (context, index) {
        //return Text('data');
        return TaskListItem(index: index, updateList: updateList);
      },
    ));
  }
}

class TaskListItem extends StatefulWidget {
  //final String label;
  final int index;
  final Function updateList;
  const TaskListItem({Key? key, required this.index, required this.updateList})
      : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState(index, updateList);
}

class _TaskItemState extends State<TaskListItem> {
  bool _isChecked = false;
  bool _done = false;

  int index;
  Function updateList;

  _TaskItemState(this.index, this.updateList);

  @override
  Widget build(BuildContext context) {
    Task task = taskList.getTask(index);
    return AnimatedContainer(
      key: UniqueKey(),
      child: InkWell(
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
                    Text(task.getTimeString,
                        style: const TextStyle(fontSize: 21)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsView(
                  task: task,
                  taskList: taskList,
                  updateList: updateList,
                ),
              ),
            );
          }),

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
