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

class mainBackground extends StatefulWidget {
  @override
  _mainBackgroundState createState() => _mainBackgroundState();
}

class _mainBackgroundState extends State<mainBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset(
        'assets/wave-loop.json',
        repeat: true,
        reverse: false,
        animate: true,
        frameRate: FrameRate(60),
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
