import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recipe_blog_app/Pages/homepage.dart';

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 10),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Center(
      //   child: Image.asset('assets/splash.png'),
      // ),
    );
  }
}