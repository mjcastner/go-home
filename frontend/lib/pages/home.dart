import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GoHomeDrawer(),
      appBar: AppBar(),
      floatingActionButton: GoHomeFab(),
    );
  }
}
