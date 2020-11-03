import 'package:BloodDoner/Screens/LoginSignUpPage.dart';
import 'package:BloodDoner/Screens/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Bank',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginSignUp(),
    );
  }
}
