// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_blog_app/Pages/introSlider.dart';
import 'package:recipe_blog_app/screens/homeScreen.dart';
import 'Pages/homepage.dart';
import 'Pages/loginPage.dart';
import 'Pages/splashScreen.dart';
import 'Pages/welcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = SplashScreen();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = SplashScreen();
      });
    } else {
      setState(() {
        page = LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: page,
    );
  }
}
