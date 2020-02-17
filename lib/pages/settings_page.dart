import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Change Address"),
            subtitle: Text("If you have moved address"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushNamed("/setup");
            },
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (context, box, widget) {
              return SwitchListTile(
                title: Text("Dark Mode"),
                subtitle: Text("Testing"),
                value: box.get("darkMode") ?? false,
                onChanged: (val) {
                  box.put("darkMode", val);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (context, box, widget) {
              return SwitchListTile(
                title: Text("Hide Info Box"),
                subtitle: Text("Hide the box reminding you to put the bins out before 7.00am"),
                value: box.get("hideInfoBox") ?? false,
                onChanged: (val) {
                  box.put("hideInfoBox", val);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}