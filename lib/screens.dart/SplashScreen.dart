import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:some_project/screens.dart/OverView_Screen.dart';

import './MaleFemale.dart';
import 'package:some_project/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Timer(
          Duration(seconds: 3),
          (() => Navigator.of(context)
              .pushReplacementNamed(OverViewScreen.routename)));
    } else {
      await prefs.setBool('seen', true);
      Timer(
        Duration(seconds: 3),
        (() =>
            Navigator.of(context).pushReplacementNamed(MaleFemale.routeName)),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => MaleFemale())));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Mycolor1,
        body: Center(
          child: Text(
            'Personal Expenses ',
            style: Theme.of(context).textTheme.headline6,
          ),
        ));
  }
}
