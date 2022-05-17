import 'package:numberpicker/numberpicker.dart';
import 'tasks.dart';
import 'taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

TaskList taskList = TaskList();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'FiraCode',
      ),
      title: 'Todo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

// TODO add tasks from database
// TODO make multiple types of tasks. time, interval, etc.
// TODO limit name lenth to 20 characters
// TODO add animation when completed

// TODO make it possible to add multiple tasks at once. 4 of (25 min, work)
// TODO remove / give up on task
// TODO edit tasks (will reset time and cannot be lower more then half of original time)
class _HomePageState extends State<HomePage> {
  var progress = taskList.getCompletedPercentage();
  var length = 0;
  var completed = 0;

  updateList() {
    setState(() {
      progress = taskList.getCompletedPercentage();
      length = taskList.getLength();

      //completed = taskList.getCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: UniqueKey(),
        appBar: AppBar(
          title: const Text('Todo'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              //TODO open drawer here
            },
          ),
        ),
        body: (() {
          if (taskList.isEmpty()) {
            return Container(
              child: Column(children: [
                //Progress(),
                Container(
                    child: const Text('No tasks todo'),
                    margin: const EdgeInsets.all(120)),
                Lottie.asset(
                  'assets/wave-loop.json',
                  repeat: true,
                  reverse: false,
                  animate: true,
                  frameRate: FrameRate(60),
                ),
              ]),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 112, 160, 255),
                    Colors.indigo
                    //Color.fromARGB(255, 77, 42, 218),
                  ],
                ),
              ),
              alignment: Alignment.topCenter,
            );
          } else {
            return Container(
              child: Column(children: const [
                //Progress(),
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
            );
          }
        }()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //showDialog(context: context, builder: const Text("data"));

            showDialog(
                context: context,
                builder: (_) => AddTaskDialog(
                      updateList: updateList,
                    ));
            //updateList();
          },
          child: const Icon(Icons.add),
        ));
  }
}

class AddTaskDialog extends StatefulWidget {
  final Function updateList;
  const AddTaskDialog({Key? key, required this.updateList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  int _currentMinutes = 15;
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
  const TaskListView({Key? key}) : super(key: key);

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
        return TaskListItem(index: index);
      },
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
                builder: (context) => TaskDetailsView(task: task),
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
