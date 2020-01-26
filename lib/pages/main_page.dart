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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Card(
              elevation: 4.0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.white, size: 42,),
                  title: Text("Please put your bin(s) out for collection before 7.00am.", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(),
          )
        ],
      ),
    );
  }
}