import 'package:flutter/material.dart';
import 'package:hackon/helper/authenticate.dart';
import 'package:hackon/helper/helperFunctions.dart';
import 'package:hackon/views/chatRooms.dart';
import 'package:hackon/views/homePage.dart';
import 'package:hackon/views/search.dart';
import 'package:hackon/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool userIsLoggedIn = false;
  void initState() {
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().
    then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: (userIsLoggedIn == true) ? HomePage() : Authenticate(),
    );
  }
}
class Blank extends StatefulWidget {
  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}








