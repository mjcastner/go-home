import 'package:flutter/material.dart';
import 'package:go_home/widgets/common.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/protos/link.pb.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

GoHomeClient goHomeStub = initGoHomeClient();

class HomePage extends StatelessWidget {
  final linkRequest = goHomeStub.batchGet(
    LinkRequestBatch(
      names: ["trololo", "blackspine", "bananaphone"],
    ),
  );

  Widget buildHomeView(List<dynamic> links) {
    List<DataRow> homeViewRows = [];
    links.forEach((link) {
      var row = DataRow(
        cells: [
          DataCell(Text(link.name)),
          DataCell(Text(link.views.toString())),
          DataCell(Text(link.targetUrl)),
          DataCell(Icon(Icons.videogame_asset)),
        ],
      );
      homeViewRows.add(row);
    });

    List<DataColumn> homeViewColumns = [
      DataColumn(label: Text("Name")),
      DataColumn(
        label: Text("Views"),
        numeric: true,
      ),
      DataColumn(label: Text("URL")),
      DataColumn(label: Text("Owner")),
    ];

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: DataTable(
        sortAscending: true,
        sortColumnIndex: 1,
        columns: homeViewColumns,
        rows: homeViewRows,
        showBottomBorder: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GoHomeDrawer(),
      appBar: AppBar(),
      floatingActionButton: GoHomeFab(),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<LinkBatch> snapshot) {
          if (snapshot.hasData) {
            dynamic linkData = snapshot.data;
            return Container(
              padding: EdgeInsets.all(20),
              child: buildHomeView(linkData.links),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error fetching links!"),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: linkRequest,
      ),
    );
  }
}
