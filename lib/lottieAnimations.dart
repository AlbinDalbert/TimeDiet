import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'tasks.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';

class computerWorkFromHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Lottie.asset(
      'assets/work-from-home.json',
      repeat: true,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
    );
  }
}

class trainingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/yoga.json',
      repeat: true,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
    );
  }
}
