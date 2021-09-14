import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';

import '../apiHandler.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.recipeTypeModel, required this.networkHandler})
      : super(key: key);

  final RecipeTypeModel? recipeTypeModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black.withOpacity(0.5),
      
                  //height: MediaQuery.of(context).size.height,
                  //width: MediaQuery.of(context).size.width,
                   height: 100,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
      
      width: MediaQuery.of(context).size.width*0.22,
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  const Color(0xffffff),
                  const Color(0xffe46b10),
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
            )
                  ),
     
      child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            ListTile(
              title: Container(
                 
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal:10),
                  decoration: BoxDecoration(
               
                  image: DecorationImage(
                    image: networkHandler.getCategoriesImage(recipeTypeModel!.productTypeName),
                    alignment: Alignment.center,
                    //fit: BoxFit.scaleDown
                    ),
              ),
                ),
                subtitle:Text(
                    recipeTypeModel!.productTypeName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
//  borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(
//                 colors: [
//                   const Color(0xffffff),
//                   const Color(0xffe46b10),
//                 ],
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp,
//             ),
