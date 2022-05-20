import 'package:flutter/material.dart';
//import 'main.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: Center(child: Text('Settings')),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color.fromARGB(255, 112, 160, 255), Colors.indigo],
          ),
        ),
      ),
    );
  }
}
