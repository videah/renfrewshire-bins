import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {

  final List<Map> bins = [
    {"name": "Green", "desc": "Plastic, cans, and glass"},
    {"name": "Grey", "desc": "Non-recyclable waste"},
    {"name": "Brown", "desc": "Garden and food waste"},
    {"name": "Blue", "desc": "Paper, card, and cardboard"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: ListView.separated(
        itemCount: bins.length,
        itemBuilder: (context, i) {
          var bin = bins[i];
          return ListTile(
            title: Text("${bin["name"]}", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${bin["desc"]}"),
            trailing: Image(
              image: AssetImage("assets/images/bin_${bin["name"].toLowerCase()}.png"),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                "/help/info",
                arguments:
                bin["name"].toLowerCase().trim(),
              );
            },
          );
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
      )
    );
  }
}
