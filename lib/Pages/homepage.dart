import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_blog_app/Pages/loginPage.dart';
import 'package:recipe_blog_app/Profile/ProfileScreen.dart';
import 'package:recipe_blog_app/screens/Blogs/addBlog.dart';
import 'package:recipe_blog_app/screens/Blogs/allBlogs.dart';
import 'package:recipe_blog_app/screens/homeScreen.dart';

import '../apiHandler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), Blogs(url: "/product/getProducts"), Blogs(url: "/product/getProducts"), ProfileScreen(), ];
  //List<String> titleString = ["Aunty Kat Recipe Blog","" "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Column(
      //           children: <Widget>[
      //             profilePhoto,
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text("@$username"),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         title: Text("All Post"),
      //         trailing: Icon(Icons.launch),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text("New Story"),
      //         trailing: Icon(Icons.add),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text("Settings"),
      //         trailing: Icon(Icons.settings),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text("Feedback"),
      //         trailing: Icon(Icons.feedback),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         title: Text("Logout"),
      //         trailing: Icon(Icons.power_settings_new),
      //         onTap: logout,
      //       ),
      //     ],
      //   ),
      // ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.1,
            child: FloatingActionButton(
              backgroundColor: Color(0xffe46b10),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddBlog()));
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          //color:  Color(0xffe46b10),
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: currentState == 0 ? Color(0xffe46b10) : Colors.black,
                    onPressed: () {
                      setState(() {
                        currentState = 0;
                      });
                    },
                    iconSize: 25,
                  ),
                  IconButton(
                    icon: Icon(Icons.analytics),
                    color: currentState == 1 ? Color(0xffe46b10) : Colors.black,
                    onPressed: () {
                      setState(() {
                        currentState = 1;
                      });
                    },
                    iconSize: 25,
                  ),
                  IconButton(
                    icon: Icon(Icons.auto_graph),
                    color: currentState == 2 ?  Color(0xffe46b10) : Colors.black,
                    onPressed: () {
                      setState(() {
                        currentState = 2;
                      });
                    },
                    iconSize: 25,
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    color: currentState == 3 ?  Color(0xffe46b10) : Colors.black,
                    onPressed: () {
                      setState(() {
                        currentState = 3;
                      });
                    },
                    iconSize: 25,
                  ),
                ],
              ),
            ),
    ),
          ),
          body: widgets[currentState]
    );

  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false);
  }
  
}
