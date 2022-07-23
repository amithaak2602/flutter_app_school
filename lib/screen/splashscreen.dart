import 'package:flutter/material.dart';
import 'package:flutter_app/screen/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToHome();


  }

  navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF345FB4),
      // decoration: new BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       colors: [
      //         Color.fromARGB(255, 25,178,238),
      //         Color.fromARGB(255, 21,236,229)
      //       ],
      //       tileMode: TileMode.clamp,
      //     )
      // ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SCHOOL",style: (TextStyle(
                fontSize: 50,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Color(0xFFFFFFFF),
                letterSpacing: 2.0
              )),),
              Text("BELL",style: (TextStyle(
                  fontSize: 50,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Color(0xFFFFFFFF),
                letterSpacing: 2.0
              )),)
            ],
          )
        ),

    );

    // TODO: implement build
    throw UnimplementedError();
  }
}
