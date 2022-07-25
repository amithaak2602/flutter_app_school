import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/AppProvider.dart';

import 'package:flutter_app/screen/splashscreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ClassRoomProvider>(
        create: (context) => ClassRoomProvider())
  ],
   child: MyApp(),));
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
      builder: EasyLoading.init(),
      home: SplashScreen(),
    );

  }
}
