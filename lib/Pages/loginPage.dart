import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_blog_app/Pages/homepage.dart';
import 'package:recipe_blog_app/Pages/registerPage.dart';
import 'package:recipe_blog_app/screens/homeScreen.dart';
import 'package:recipe_blog_app/widgets/bezierContainer.dart';
import '../apiHandler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String errorText ;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(children: <Widget>[
        Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer()),
        Container(
          child: Form(
            key: _globalkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _title(),
                  SizedBox(
                    height: 40,
                  ),
                  usernameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  passwordTextField(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ForgotPasswordPage()));
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "New User?",
                          style: TextStyle(
                            color: Color(0xffe46b10),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });

                      //Login Logic start here
                      Map<String, String> data = {
                        "username": _usernameController.text,
                        "password": _passwordController.text,
                      };
                      var response =
                          await networkHandler.post("/user/login", data);

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> output =
                            json.decode(response.body);
                        print(output["token"]);
                        await storage.write(
                            key: "token", value: output["token"]);
                        setState(() {
                          validate = true;
                          circular = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (route) => false);
                      } else {
                        String output = json.decode(response.body);
                        setState(() {
                          validate = false;
                          errorText = output;
                          circular = false;
                        });
                      }

                      // login logic End here
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xfffbb448), Color(0xffe46b10)])),
                      child: Center(
                        child: circular
                            ? CircularProgressIndicator()
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "assets/facebook.png",
                            height: 30,
                            width: 30,
                          ),
                        SizedBox(width: 20),
                        Image.asset(
                            "assets/google.png",
                            height: 30,
                            width: 30,
                          ),
                      ],
                    ),
                  )
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }

  Widget usernameTextField() {
    return Column(
      children: [
        Text("Username"),
        TextFormField(
          controller: _usernameController,
         decoration: InputDecoration(
           //errorText: validate ? null : errorText,
          focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
          )
           )
        )
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        TextFormField(
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            //errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Aunty',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: ' Kat',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Recipe Blogs',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}
