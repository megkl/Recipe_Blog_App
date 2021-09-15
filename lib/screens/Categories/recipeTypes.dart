import 'package:flutter/material.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/CustumWidget/CategoryCard.dart';
import 'package:recipe_blog_app/Model/CategorySuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';
import 'package:recipe_blog_app/screens/Categories/recipeType.dart';

import '../../apiHandler.dart';

class RecipeCategories extends StatefulWidget {
  const RecipeCategories({ Key? key, required this.url }) : super(key: key);
  final String url;

  @override
  _RecipeCategoriesState createState() => _RecipeCategoriesState();
}

class _RecipeCategoriesState extends State<RecipeCategories> {
   NetworkHandler networkHandler = NetworkHandler();
  CategorySuperModel categorySuperModel = CategorySuperModel();
  List<RecipeTypeModel?>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    categorySuperModel = CategorySuperModel.fromJson(response);
    setState(() {
      data = categorySuperModel.data;
    });
  }
   @override
  Widget build(BuildContext context) {
    return data!.length > 0
        ? ListView(
         scrollDirection: Axis.horizontal,
         padding: EdgeInsets.only(left: 10),
            children: data
                !.map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => RecipeCategory(
                                          recipeTypeModel: item,
                                          networkHandler: networkHandler,
                                        )));
                          },
                          child: CategoryCard(
                            recipeTypeModel: item,
                            networkHandler: networkHandler,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any categories Yet"),
          );
  }
}