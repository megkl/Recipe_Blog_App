import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/CustumWidget/BlogPerCategoryCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/blogs/blog.dart';

import '../../apiHandler.dart';

class FavouriteBlogs extends StatefulWidget {
  FavouriteBlogs({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _FavouriteBlogsState createState() => _FavouriteBlogsState();
}

class _FavouriteBlogsState extends State<FavouriteBlogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel?>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:   MediaQuery.of(context).size.height,
       color: Color(0xffEEEEFF),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _title(),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(top: 45),
              child: buildFloatingSearchBar(),
            ),
            SizedBox(height: 20),
          data!.length > 0
                ? Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: ListView(
                      children: data!
                          .map((item) => Column(
                                children: <Widget>[
                                  Material(
                                    //color: Color(0xffEEEEFF),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) => RecipeBlog(
                                                      addBlogModel: item,
                                                      networkHandler: networkHandler,
                                                    )));
                                      },
                                      child: BlogcategoryCard(
                                        addBlogModel: item,
                                        networkHandler: networkHandler,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                )
                : Center(
                    child: Text("We don't have any recipe category Favourite Blogs Yet",style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffe46b10)),
                )),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:"Favourite Recipes",
            style: GoogleFonts.tangerine(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color:Colors.black,
            ),
            ),
      ),
    );
  }
 Widget buildFloatingSearchBar() {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}