import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/pages/post_create.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

GoHomeClient goHomeStub = initGoHomeClient();

class CreatePage extends StatelessWidget {
  String linkName = "";

  CreatePage(String linkName) {
    this.linkName = linkName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            GoHomeInput(this.linkName),
          ],
        ),
      ),
    );
  }
}

class GoHomeInput extends StatefulWidget {
  String linkName = "";

  GoHomeInput(String linkName) {
    this.linkName = linkName;
  }

  @override
  _GoHomeInputState createState() => _GoHomeInputState(this.linkName);
}

class _GoHomeInputState extends State<GoHomeInput> {
  final _formKey = GlobalKey<FormState>();
  String linkName = "";
  String linkUrl = "";

  _GoHomeInputState(String linkName) {
    this.linkName = linkName;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Link name'),
              initialValue: this.linkName,
              // initialValue: this.linkName,
              validator: (value) {
                RegExp linkNameRegex = new RegExp(r"^[A-Za-z0-9]{1,50}$");
                if (linkNameRegex.hasMatch(value.toString())) {
                  return null;
                } else {
                  return "Link names can only contain alphanumeric characters";
                }
              },
              onSaved: (value) {
                this.linkName = value.toString();
              },
            ),
            height: 75,
            width: 300,
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Target URL'),
              validator: (value) {
                RegExp linkUrlRegex = new RegExp(
                    r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)");
                if (linkUrlRegex.hasMatch(value.toString())) {
                  return null;
                } else {
                  return "Invalid URL";
                }
              },
              onSaved: (value) {
                RegExp httpPrefixRegex = new RegExp(r"^http");
                if (httpPrefixRegex.hasMatch(value.toString())) {
                  this.linkUrl = value.toString();
                } else {
                  this.linkUrl = 'http://${value.toString()}';
                }
              },
            ),
            height: 75,
            width: 300,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Link linkProto = Link(
                  name: this.linkName,
                  targetUrl: this.linkUrl,
                );
                var setResponse = goHomeStub.set(linkProto);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PostCreatePage(setResponse, linkProto)),
                );
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }
}
