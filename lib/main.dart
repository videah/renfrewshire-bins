import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flipper_client.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:renfrewshire_bins/pages/postcode.dart';

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
      home: PostcodePage(),
    );
  }
}