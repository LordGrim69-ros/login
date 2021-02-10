import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lendigi/homepage.dart';
import 'package:lendigi/loginpage.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Scaffold(
              body: Text("Error Loading"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User user = snapshot.data;
                  if (user == null) {
                    return HomePage();
                  } else {
                    return Loginpage();
                  }
                } else {
                  return Scaffold(
                    body: Text('loading Stream Builder'),
                  );
                }
              },
            );
          } else {
            return Scaffold(
              body: Text('loading'),
            );
          }
        });
  }
}
