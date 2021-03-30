import 'dart:async';

import 'package:cafe_order/screen/mian_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cafe_order/globals.dart' as globals;

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    path: "lang",
    saveLocale: true,
    supportedLocales: [
      Locale('uz', 'UZ'),
      Locale('ru', 'RU'),
      Locale('en', 'US'),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Order',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xff1A508B),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadScreen(),
    );
  }
}

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  Timer timer;

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // setState(() {

    await getTable();
    // });
  }

  getTable() async {
    try {
      var url = '${globals.apiLink}tables';
      var response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        globals.tables = response.json();
      } else {
        dynamic json = response.json();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getStringValuesSF();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) {
        return MainScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SvgPicture.asset(
            'assets/img/logo-cafe.svg',
            height: 120,
          ),
        ),
      ),
    );
  }
}
