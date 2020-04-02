import 'package:about/about.dart';
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
          ValueListenableBuilder(
            valueListenable: Hive.box("details").listenable(),
            builder: (context, box, widget) {
              String address = box.get("addressString").split(",").first;
              return ListTile(
                title: Text("Change Address"),
                subtitle: Text("$address"),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.home),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/setup");
                },
              );
            },
          ),
          Divider(),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (context, box, widget) {
              return SwitchListTile(
                title: Text("Enable Dark Mode"),
                subtitle: Text("Make things a little easier on the eyes"),
                secondary: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.format_paint),
                ),
                value: box.get("darkMode") ?? false,
                onChanged: (val) {
                  box.put("darkMode", val);
                },
              );
            },
          ),
          Divider(),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (context, box, widget) {
              return SwitchListTile(
                title: Text("Hide Info Box"),
                subtitle: Text(
                  "Get rid of the box reminding you to put the bins out before 7.00am",
                ),
                secondary: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.perm_device_information),
                ),
                value: box.get("hideInfoBox") ?? false,
                onChanged: (val) {
                  box.put("hideInfoBox", val);
                },
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("About"),
            subtitle: Text("Application info & software licenses"),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              child: Icon(Icons.info_outline),
            ),
            onTap: () {
              showAboutPage(
                context: context,
                applicationName: "Renfrewshire Bins",
                applicationVersion: "Version 1.0.0",
                applicationLegalese: "Ruairidh 'videah' Carmichael",
                applicationIcon: FlutterLogo(),
                applicationDescription: const Text(
                    "Unofficial bin collection tracker for residents living in Renfrewshire\n\nThis app is not endorsed by Renfrewshire Council in anyway, I created this for my own personal use. It is entirely possible for operation of this app to discontinue at the wishes of Renfrewshire Council."),
                children: [
                  LicensesPageListTile(
                    title: Text("Open Source Licenses"),
                    icon: Icon(Icons.share),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
