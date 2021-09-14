import 'package:flutter/material.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';
import '../../apiHandler.dart';

class RecipeCategory extends StatelessWidget {
  @override
  const RecipeCategory({Key? key, required this.recipeTypeModel, required this.networkHandler})
      : super(key: key);
  final RecipeTypeModel? recipeTypeModel;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            height: 365,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Row(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: networkHandler.getCategoriesImage(recipeTypeModel!.productTypeName),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      recipeTypeModel!.productTypeName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
