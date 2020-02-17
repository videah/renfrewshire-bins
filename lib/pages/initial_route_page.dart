import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class InitialRoutePage extends StatefulWidget {
  @override
  _InitialRoutePageState createState() => _InitialRoutePageState();
}

class _InitialRoutePageState extends State<InitialRoutePage> {

  Future _initializeDatabase() async {
    // We store the info securely because why not?
    // Kinda moot since the API requires sending details over in
    // plaintext but whatever.
    var keystore = FlutterSecureStorage();
    var read = await keystore.read(key: "hive-key");
    var key = read ?? base64.encode(Hive.generateSecureKey());
    if (read == null) await keystore.write(key: "hive-key", value: key);

    // We need a place to store the actual HiveDB contents.
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    // Let's open some boxes.
    return Future.wait([
      Hive.openBox("details"),
      Hive.openBox("settings")
    ]);

  }

  void _checkForInitialRoute() async {
    await Future.delayed(Duration(milliseconds: 100));
    await _initializeDatabase();
    var storage = Hive.box("details");
    var details = await storage.get("address");
    var route = details != null ? "/main" : "/setup";
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  void initState() {
    _checkForInitialRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}