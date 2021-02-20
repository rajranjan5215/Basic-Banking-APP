import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'allcustomers.dart';
import 'dart:async';

import 'myhomepage.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Banking App',
      theme: ThemeData(
        primaryColor:  Color.fromRGBO(32, 132, 113, 1),
        
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MyHomePage(),
        '/all': (BuildContext context) => Allcustomers(),
        'home':(BuildContext context) => HomeScreen(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromRGBO(32, 132, 113, 1),
          body: Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/HomeScreen.jpg",
                ),
              ),
            ),
          ),
        ));
  }
}

