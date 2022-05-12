import 'dart:async';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'tasks.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TaskDetailsView extends StatefulWidget {
  final Task task;
  const TaskDetailsView({Key? key, required this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskDetailsView(task);
}

class _TaskDetailsView extends State<TaskDetailsView> {
  Task task;
  _TaskDetailsView(this.task);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text(task.getName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //TODO go back to previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          child: Column(children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                //padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.4,
                child: CircularPercentIndicator(
                    radius: 160,
                    progressColor: Colors.indigo,
                    backgroundColor: Colors.white38,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(task.getTimeString,
                        style: TextStyle(fontSize: 30)),
                    percent: 0.4,
                    lineWidth: 30.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 8),
                    left: BorderSide(color: Colors.black12, width: 8),
                    right: BorderSide(color: Colors.white12, width: 8),
                    top: BorderSide(color: Colors.white24, width: 8),
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(40),
                        child: Text(task.getName,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))),
                    Flexible(
                        child: Column(
                      children: [
                        Text(task.getDescription,
                            style: TextStyle(fontSize: 20)),
                        Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.1),
                              ),
                              child: Text("Start"),
                              onPressed: () {
                                task.startTask();
                                setState(() {});
                              }),
                          margin: EdgeInsets.all(40),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )),
                  ],
                ),
                decoration: const BoxDecoration(
                    //color: Color.fromARGB(255, 157, 175, 212),
                    color: Colors.white38,
                    border: Border(
                        //bottom: BorderSide(color: Colors.black26, width: 8),
                        //left: BorderSide(color: Colors.black12, width: 8),
                        //right: BorderSide(color: Colors.white12, width: 8),
                        //top: BorderSide(color: Colors.white, width: 8),
                        ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ))),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 112, 160, 255), Colors.indigo],
            ),
          ),
          alignment: Alignment.center),
    );
  }
}
