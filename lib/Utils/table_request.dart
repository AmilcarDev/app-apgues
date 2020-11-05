import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/models/request_model.dart';

class TableRequest extends StatefulWidget {
  int stage;
  List<GroupRequest> dataList;

  TableRequest(int stage) {
    this.stage = stage;
    print('stage->$stage');
    this.dataList = requestG[stage - 1];
  }

  @override
  _TableRequestState createState() => _TableRequestState();
}

class _TableRequestState extends State<TableRequest> {
  List<DataRow> _rows() {
    List<DataRow> rowList = new List<DataRow>();
    for (var request in widget.dataList) {
      rowList.add(DataRow(cells: [
        new DataCell(
          Text(request.name),
        ),
        new DataCell(
          Text(request.sendTo),
        )
      ]));
    }
    return rowList;
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: false,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
            label: Text("Solicitud"),
            numeric: false,
            tooltip: "Nombre de la solicitud",
          ),
          DataColumn(
            label: Text("Estado"),
            numeric: false,
            tooltip: "Estado actual de la solicitud",
          ),
        ],
        rows: _rows(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dataBody();
  }
}
