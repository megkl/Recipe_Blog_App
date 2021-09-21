import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../apiHandler.dart';

class CategoryRecipes extends StatefulWidget {
  const CategoryRecipes({ Key? key, required this.url, required this.recipeCategory }) : super(key: key);
  final String url;
  final String recipeCategory;
  @override
  _CategoryRecipesState createState() => _CategoryRecipesState();
}

class _CategoryRecipesState extends State<CategoryRecipes> {
   NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  //AddBlogModel addBlogModel = AddBlogModel(body: '', coverImage: '', duration: 0, id: '', ingredients: '', procedure: '', productTypeName: '', title: '', username: '');
  final AddBlogModel? addBlogModel = AddBlogModel(body: '', coverImage: '', duration: 0, id: '', ingredients: '', procedure: '', productTypeName: '', title: '', username: '');
   List<AddBlogModel?>? data = [];
  int _currentIndex = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url+"/${widget.recipeCategory}");
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }
   @override
  Widget build(BuildContext context) {
   return data!.length > 0
        ? ListView(
            children: data!
                .map((item) => Column(
                      children: <Widget>[
                        Container(
                          
                          child: BlogCard(
                                addBlogModel: item,
                                networkHandler: networkHandler,
                              ),
                        ),
                        //Container(
                          // child: InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (contex) => RecipeBlog(
                          //                   addBlogModel: item,
                          //                   networkHandler: networkHandler,
                          //                 )));
                          //   },
                          //   child: BlogCard(
                          //     addBlogModel: item,
                          //     networkHandler: networkHandler,
                          //   ),
                          // ),
                        //),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any recipe category blogs Yet"),
          );
  }
}