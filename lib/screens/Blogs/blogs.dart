import 'package:flutter/material.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';

import '../../apiHandler.dart';

class RecipeBlogs extends StatefulWidget {
  const RecipeBlogs({ Key? key, required this.url }) : super(key: key);
  final String url;

  @override
  _RecipeBlogsState createState() => _RecipeBlogsState();
}

class _RecipeBlogsState extends State<RecipeBlogs> {
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
    return data!.length > 0
        ? ListView(
            children: data
                !.map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => RecipeBlog(
                                          addBlogModel: item,
                                          networkHandler: networkHandler,
                                        )));
                          },
                          child: BlogCard(
                            addBlogModel: item,
                            networkHandler: networkHandler,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any recipe blogs Yet"),
          );
  }
}