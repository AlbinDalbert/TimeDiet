import 'package:numberpicker/numberpicker.dart';
import 'package:todo_list/settingsView.dart';
import 'WorkList/tasks.dart';
import 'WorkList/taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'WorkList/workList.dart';
import 'drawer.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('TimeDiet'),
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 112, 160, 255),
            Colors.indigo,
          ],
        ),
      ),
    );
  }
}
