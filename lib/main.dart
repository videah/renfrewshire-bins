import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flipper_client.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:renfrewshire_bins/pages/initial_route_page.dart';
import 'package:renfrewshire_bins/pages/main_page.dart';
import 'package:renfrewshire_bins/pages/postcode_page.dart';

void main() {
  FlipperClient flipper = FlipperClient.getDefault();
  flipper.addPlugin(FlipperNetworkPlugin(
    useHttpOverrides: true,
  ));
  flipper.start();
  runApp(BinApp());
}

class BinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        "/": (context) => InitialRoutePage(),
        "/setup": (context) => PostcodePage(),
        "/main": (context) => MainPage(),
      },
    );
  }
}