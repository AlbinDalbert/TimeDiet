import 'package:numberpicker/numberpicker.dart';
import 'package:todo_list/settingsView.dart';
import 'WorkList/tasks.dart';
import 'WorkList/taskDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'WorkList/workList.dart';
import 'drawer.dart';
import 'background.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      mainBackground(),
      Column(
        children: [
          Container(
              child: const Center(
                  child: Text('TimEDieT',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold))),
              margin: const EdgeInsets.only(top: 50)),
        ],
      )
    ]);
  }
}
