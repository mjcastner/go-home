import 'package:flutter/material.dart';
import 'package:go_home/protos/server.pbgrpc.dart';
import 'package:go_home/utils/grpc.dart';
import 'package:go_home/widgets/common.dart';
import 'package:url_launcher/url_launcher.dart';

GoHomeClient goHomeStub = initGoHomeClient();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sortAsc = true;
  int sortIndex = 0;
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
          DataCell(
            Text(link.targetUrl),
            onTap: () {
              launch(link.targetUrl);
              setState(() {});
              link.views += 1;
              goHomeStub.set(link);
            },
          ),
          DataCell(
            CircleAvatar(
              radius: 13,
              backgroundImage: AssetImage("images/profile.jpeg"),
            ),
          ),
          DataCell(Row(
            children: [
              IconButton(
                onPressed: () => {print("Edit")},
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => {
                  links.removeWhere((element) => element.name == link.name),
                  goHomeStub
                      .delete(LinkRequest(name: link.name))
                      .whenComplete(() => setState(() {}))
                },
                icon: Icon(Icons.delete),
              ),
            ],
          )),
        ],
      );
      homeViewRows.add(row);
    });

    List<DataColumn> homeViewColumns = [
      DataColumn(
        label: Text("Name"),
        onSort: (columnIndex, _) {
          setState(() {
            this.sortIndex = columnIndex;
            if (this.sortAsc) {
              this.sortAsc = false;
              links.sort((a, b) => b.name.compareTo(a.name));
            } else {
              this.sortAsc = true;
              links.sort((a, b) => a.name.compareTo(b.name));
            }
          });
        },
      ),
      DataColumn(
        label: Text("Views"),
        numeric: true,
        onSort: (columnIndex, _) {
          setState(() {
            this.sortIndex = columnIndex;
            if (this.sortAsc) {
              this.sortAsc = false;
              links.sort((a, b) => b.views.compareTo(a.views));
            } else {
              this.sortAsc = true;
              links.sort((a, b) => a.views.compareTo(b.views));
            }
          });
        },
      ),
      DataColumn(label: Text("URL")),
      DataColumn(label: Text("Owner")),
      DataColumn(label: Text("Actions")),
    ];

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: DataTable(
        sortAscending: this.sortAsc,
        sortColumnIndex: this.sortIndex,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error fetching links!"),
                Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: Colors.red),
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
        future: linkRequest,
      ),
    );
  }
}
