import 'package:flutter/material.dart';
// import 'package:cocktail_app/models/cocktail.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Box<dynamic> settingsBox;

  void setup() async {}

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settings');
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingsBox.listenable(),
        builder: (context, Box<dynamic> box, widget) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: const Center(
              child: Text('Settings Page'),
            ),
          );
        });
  }
}
