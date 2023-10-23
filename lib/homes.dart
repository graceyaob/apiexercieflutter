import 'package:flutter/material.dart';
import 'apiDio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> data = [];

  /*void recuperationDonneeApi() async {
    List<Map<String, dynamic>> apiData = await apiget();
    setState(() {
      data = apiData;
    });
  }*/

  @override
  void initState() {
    super.initState();
    //recupération des données de l'api
    apiget().then((value) => {
          setState(() {
            data = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Listes des maisons en lignes"),
        ),
        body: Center(
            child: DataTable(
          columns: [
            DataColumn(label: Text("Ticker")),
            DataColumn(
              label: Text("Nom"),
            ),
            DataColumn(label: Text("Is_etf")),
            DataColumn(label: Text("Echange"))
          ],
          rows: data.map((rowData) {
            return DataRow(cells: [
              DataCell(Text(rowData['libelle'] ?? '-')),
              DataCell(Text(rowData['description'] ?? '-')),
              DataCell(Text(rowData['url']?.toString() ?? '-')),
              DataCell(Text(rowData['id'] ?? '-'))
            ]);
          }).toList(),
        )));
  }
}
