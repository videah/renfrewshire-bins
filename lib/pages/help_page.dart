import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  List<String> bins = ["Blue", "Brown", "Green", "Grey"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: GridView.builder(
        itemCount: bins.length,
        padding: const EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
        ),
        itemBuilder: (context, i) {
          return Card(
            elevation: 2.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/bin_${bins[i].toLowerCase()}.jpg"),
                        width: 85,
                      ),
                      Text("${bins[i]}", style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.deepPurple.withAlpha(200),
                      highlightColor: Colors.deepPurple.withAlpha(100),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
