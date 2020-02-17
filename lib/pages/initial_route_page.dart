import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InitialRoutePage extends StatefulWidget {
  @override
  _InitialRoutePageState createState() => _InitialRoutePageState();
}

class _InitialRoutePageState extends State<InitialRoutePage> {

  void _checkForInitialRoute() async {
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