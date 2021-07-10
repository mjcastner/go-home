import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GoHomeDrawer(),
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cool feature 1"),
                Switch(
                  value: false,
                  onChanged: (bool switchState) => {print(switchState)},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cool feature 2"),
                Switch(
                  value: false,
                  onChanged: (bool switchState) => {print(switchState)},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cool feature 3"),
                Switch(
                  value: false,
                  onChanged: (bool switchState) => {print(switchState)},
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(100)),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Links owned",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () => {print("Pressed")},
                  child: Text("Delete all owned links"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
