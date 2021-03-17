import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamta_project/Homepage.dart';
enum AuthStatus{
  signedIn,
  notSignedIn
}
class SignInPage extends StatelessWidget{
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  signInAnonymous() async{
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  }
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 30.0,
            title: Text(
              'SignIn',
              style: TextStyle(color: Colors.white,fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
              padding: EdgeInsets.fromLTRB(150.0, 50.0, 50.0, 0.0),
              child: ElevatedButton(
            onPressed: () {
              signInAnonymous();
              Navigator.pushNamed(context, '/Homepage');
            },
            child: Container(
              color: Colors.blue,
              child: Text(
                'SigIn',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30.0),
              ),),
          )),
        );
      case AuthStatus.signedIn:
        return Homepage();

  }
  }
}