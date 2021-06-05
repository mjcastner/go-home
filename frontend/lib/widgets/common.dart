import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  "Header",
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
                  ListTile(title: Text("All links")),
                  ListTile(title: Text("My links")),
                  ListTile(title: Text("Create a link")),
                ],
              ),),
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
        Fluttertoast.showToast(
          msg: "Navigate to link creation.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        )
      },
    );
  }
}