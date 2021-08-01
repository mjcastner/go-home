import 'dart:html';

import 'package:flutter/material.dart';

class GoHomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 125,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "GoHome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ListView(
              children: [
                ListTile(
                  title: Text("My links"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/',
                    );
                  },
                ),
                ListTile(
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/settings',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GoHomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => {
        Navigator.pushNamed(
          context,
          '/create/',
        )
      },
    );
  }
}
