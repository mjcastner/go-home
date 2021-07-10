import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pb.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/protos/server.pbgrpc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart' as url_launcher_link;

class PostCreatePage extends StatelessWidget {
  Future? _setResponse;
  Link? _link;

  PostCreatePage(Future setResponse, Link link) {
    this._setResponse = setResponse;
    this._link = link;
  }

  void _launchURL() async => await canLaunch(this._link!.targetUrl)
      ? await launch(this._link!.targetUrl)
      : throw 'Could not launch ${this._link!.targetUrl}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pushNamed(context, '/')},
        ),
      ),
      floatingActionButton: GoHomeFab(),
      body: FutureBuilder(
        future: this._setResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            SetResponse response = snapshot.data as SetResponse;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    url_launcher_link.Link(
                      uri: Uri.parse(_link!.targetUrl),
                      target: url_launcher_link.LinkTarget.blank,
                      builder: (ctx, openLink) {
                        return TextButton.icon(
                          onPressed: openLink,
                          label: Text("go/${_link!.name}"),
                          icon: Icon(Icons.link),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
