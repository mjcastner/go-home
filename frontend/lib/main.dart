import 'package:flutter/material.dart';
import 'package:go_home/pages/home.dart';

void main() {
  runApp(GoHome());
}

class GoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
      title: 'GoHome, a go link server for use...at home.',
    );
  }
}
