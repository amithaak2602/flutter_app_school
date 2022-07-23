import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_app/screen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF345FB4),
        primaryColor:  Color(0xFF345FB4),
      ),
      home: SplashScreen(),
    );

  }
}
