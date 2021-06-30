import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

class CreatePage extends StatelessWidget {
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
            GoHomeInput(),
          ],
        ),
      ),
      floatingActionButton: GoHomeFab(),
    );
  }
}

class GoHomeInput extends StatefulWidget {
  @override
  _GoHomeInputState createState() => _GoHomeInputState();
}

class _GoHomeInputState extends State<GoHomeInput> {
  final _formKey = GlobalKey<FormState>();
  String? _linkName = '';
  String? _linkUrl = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(padding: EdgeInsets.all(5)),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Link name'),
                      onSaved: (value) {
                        _linkName = value;
                      },
                    ),
                    height: 50,
                    width: 250,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(50)),
              Column(
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Target URL'),
                      onSaved: (value) {
                        _linkUrl = value;
                      },
                    ),
                    height: 50,
                    width: 250,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    print(_linkName);
                    print(_linkUrl);
                  },
                  child: Text("Create")),
            ],
          ),
        ],
      ),
    );
  }
}
