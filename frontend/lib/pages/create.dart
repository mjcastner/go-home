import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

class CreatePage extends StatefulWidget {
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GoHomeDrawer(),
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Row(
              children: [
                Text("Create a link"),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 250,
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "/",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: GoHomeFab(),
    );
  }
}
