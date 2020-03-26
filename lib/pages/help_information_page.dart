import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HelpInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String bin = ModalRoute.of(context).settings.arguments;
    final String displayName = bin[0].toUpperCase() + bin.substring(1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your $displayName Bin"),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("assets/images/banner_$bin.jpg"),
          FutureBuilder(
            future: rootBundle.loadString("assets/html/$bin.html"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return HtmlWidget(snapshot.data);
            },
          )
        ],
      ),
    );
  }
}
