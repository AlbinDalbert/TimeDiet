import 'package:numberpicker/numberpicker.dart';
import 'package:todo_list/settingsView.dart';
import 'WorkList/tasks.dart';
import 'WorkList/taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'WorkList/workList.dart';
import 'drawer.dart';
import 'mainPage.dart';

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

// TODO remove / give up on task
// TODO edit tasks (will reset time and cannot be lower more then half of original time)
class _HomePageState extends State<HomePage> {
  late NavDrawer navDrawer;
  var _selectedIndex = 1;

  final _pages = [const WorkList(), MainPage(), SettingsView()];

  @override
  Widget build(BuildContext context) {
    navDrawer = NavDrawer(context);
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: const Text('TimeDiet'),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      drawer: navDrawer.drawer,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Work List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }

  _onItemTap(int index) {
    setState(() {
      if (_selectedIndex == index) {
        return;
      }
      _selectedIndex = index;
    });
  }
}
