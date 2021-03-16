

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mamta_project/Homepage.dart';
import 'package:mamta_project/SignInpage.dart';
import 'Database.dart';
import 'Homepage.dart';
import 'SignInpage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
      home: MyApp(),
    routes: <String, WidgetBuilder> {
       '/Database': (context) => GetUserName(),
      '/Homepage': (context) => Homepage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(
            'connection gone'
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SignInPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}