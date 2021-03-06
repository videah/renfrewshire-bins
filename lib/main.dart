import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renfrewshire_bins/pages/help_information_page.dart';
import 'package:renfrewshire_bins/pages/help_page.dart';
import 'package:renfrewshire_bins/pages/initial_route_page.dart';
import 'package:renfrewshire_bins/pages/main_page.dart';
import 'package:renfrewshire_bins/pages/postcode_page.dart';
import 'package:renfrewshire_bins/pages/settings_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // We need a place to store the actual HiveDB contents.
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  // Let's open some boxes.
  await Hive.openBox("details");
  await Hive.openBox("settings");
  runApp(BinApp());
}

class BinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context, box, widget) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: box.get("darkMode") ?? false == true ? Brightness.dark : Brightness.light,
          ),
          routes: {
            "/": (context) => InitialRoutePage(),
            "/setup": (context) => PostcodePage(),
            "/main": (context) => MainPage(),
            "/settings": (context) => SettingsPage(),
            "/help": (context) => HelpPage(),
            "/help/info": (context) => HelpInformationPage(),
          },
        );
      },
    );
  }
}