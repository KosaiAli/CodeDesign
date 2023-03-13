import 'package:codedesign/Screens/home_screen.dart';
import 'package:codedesign/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: FirebaseAuth.instance.currentUser == null
                ? const LoginScreen()
                : const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
        return MaterialApp(
          home: Scaffold(
            body: Container(),
          ),
        );
      },
    );
  }
}
