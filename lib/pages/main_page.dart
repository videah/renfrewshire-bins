import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Renfrewshire Bins"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            tooltip: "Help",
            onPressed: () {
              Navigator.of(context).pushNamed("/help");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
        ],
      ),
    );
  }
}