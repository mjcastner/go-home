import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:go_home/utils/routes.dart';
import 'package:go_home/pages/home.dart';
import 'package:go_home/pages/create.dart';
import 'package:go_home/pages/settings.dart';

void main() {
  runApp(GoHome());
}

class GoHome extends StatelessWidget {
  GoHome() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    GoHomeRouter.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'GoHome',
      onGenerateRoute: GoHomeRouter.router.generator,
    );
  }
}
