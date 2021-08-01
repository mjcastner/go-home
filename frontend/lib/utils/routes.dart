import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:go_home/pages/create.dart';
import 'package:go_home/pages/home.dart';
import 'package:go_home/pages/settings.dart';
import 'package:go_home/protos/server.pbgrpc.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:url_launcher/url_launcher.dart';

GoHomeClient goHomeStub = initGoHomeClient();

// Implement HTML handler to get rid of extra tab
// https://stackoverflow.com/questions/56220691/how-do-i-open-an-external-url-in-flutter-web-in-new-tab-or-in-same-tab
var linkHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var linkName = params["link"]![0];

  if (linkName != "") {
    final linkRequest = goHomeStub.get(LinkRequest(name: linkName));
    linkRequest.then((link) {
      if (link.targetUrl != "") {
        launch(link.targetUrl);
      } else {
        Navigator.pushNamed(context!, "/create/${linkName}");
      }
    });
  }
});

var createHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var linkName = params["link"]![0];
  return CreatePage(linkName);
});

var homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return HomePage();
});

var settingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SettingsPage();
});

class GoHomeRouter {
  static late final FluroRouter router;
}

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return;
    });

    // Route definitions
    router.define("/", handler: homeHandler);
    router.define("/link/:link", handler: linkHandler);
    router.define("/create/:link", handler: createHandler);
    router.define("/settings", handler: settingsHandler);
  }
}
