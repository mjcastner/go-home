import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/pages/post_create.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

GoHomeClient goHomeStub = initGoHomeClient();

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
    );
  }
}

class GoHomeInput extends StatefulWidget {
  @override
  _GoHomeInputState createState() => _GoHomeInputState();
}

class _GoHomeInputState extends State<GoHomeInput> {
  final _formKey = GlobalKey<FormState>();
  String _linkName = '';
  String _linkUrl = '';

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
              validator: (value) {
                RegExp linkNameRegex = new RegExp(r"^[A-Za-z0-9]{1,50}$");
                if (linkNameRegex.hasMatch(value.toString())) {
                  return null;
                } else {
                  return "Link names can only contain alphanumeric characters";
                }
              },
              onSaved: (value) {
                _linkName = value.toString();
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
                _linkUrl = value.toString();
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
                  name: _linkName,
                  targetUrl: _linkUrl,
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
