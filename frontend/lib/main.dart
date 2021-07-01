import 'package:flutter/material.dart';
import 'package:go_home/pages/home.dart';
import 'package:go_home/pages/create.dart';
import 'package:go_home/pages/settings.dart';

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
        '/new': (context) => CreatePage(),
        '/settings': (context) => SettingsPage(),
      },
      title: 'GoHome, a go link server for use...at home.',
    );
  }
}
