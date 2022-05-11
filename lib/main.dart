import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:some_project/providers.dart/User_Transaction.dart';
import 'package:some_project/screens.dart/OverView_Screen.dart';

import './screens.dart/MaleFemale.dart';

import './screens.dart/NameEmail.dart';

import './screens.dart/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = '/homePage';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserTransaction())
      ],
      child: MaterialApp(
        title: 'personal expenses',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(42, 42, 42, 1),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromRGBO(25, 24, 24, 1),
              )),
        ),
        routes: {
          '/': (context) => SplashScreen(),
          MaleFemale.routeName: (context) => MaleFemale(),
          NameEmail.routeName: (context) => NameEmail(),
          OverViewScreen.routename: (context) => OverViewScreen(),
        },
      ),
    );
  }
}

const Mycolor1 = Color.fromRGBO(230, 245, 252, 1);
const Mycolor = Color.fromRGBO(230, 220, 245, 1);
const colortext = Color.fromRGBO(25, 24, 24, 1);
