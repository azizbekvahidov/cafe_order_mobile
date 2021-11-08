import './mian_screen.dart';
import '../widget/custon_appbar.dart';
// import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController urlController = TextEditingController();
  bool isPing = false;

  void onSave() async {
    // ConnectivityUtils.instance.setServerToPing(urlController.text);
    // ConnectivityUtils.instance.setCallback((response) {
    //   isPing = true;

    //   return true;
    // });
    setSharedPref();
  }

  setSharedPref() async {
    globals.apiLink = "http://${urlController.text}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", "http://${urlController.text}");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) {
      return MainScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: "Настройки",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: urlController,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          onSave();
        },
      ),
    );
  }
}
