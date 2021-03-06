import 'package:flutter/material.dart';
import 'package:some_project/screens.dart/OverView_Screen.dart';

import './NameEmail.dart';
import '../main.dart';

class MaleFemale extends StatefulWidget {
  static const routeName = '/maleFemale';

  @override
  State<MaleFemale> createState() => _MaleFemaleState();
}

class _MaleFemaleState extends State<MaleFemale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Mycolor1,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NameEmail.routeName);
                },
                icon: Icon(
                  Icons.male,
                  color: colortext,
                ),
                focusColor: Mycolor,
                iconSize: 70,
              ),
              Container(
                width: 20,
                child: FittedBox(
                    child: Text(
                  'Or',
                  style: Theme.of(context).textTheme.headline6,
                )),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => OverViewScreen()));
                },
                icon: Icon(
                  Icons.female,
                  color: colortext,
                ),
                focusColor: Mycolor,
                iconSize: 70,
              ),
            ],
          ),
        ));
  }
}
