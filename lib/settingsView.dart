import 'package:flutter/material.dart';
import 'background.dart';
//import 'main.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [mainBackground(), const Center(child: Text('Settings'))],
      ),
    );
  }
}
