import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';

import '../apiHandler.dart';

class BlogcategoryCard extends StatelessWidget {
  const BlogcategoryCard(
      {Key? key, required this.addBlogModel, required this.networkHandler})
      : super(key: key);

  final AddBlogModel? addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.0,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
//             Container(
//               child: ListTile(
//                 title: Text(addBlogModel!.title),
//                 trailing: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: networkHandler.getImage(addBlogModel!.id),
//                       fit: BoxFit.contain,
//                       scale: 0.01
//                       )),),
// subtitle: Text(addBlogModel!.body),
//                 ),
//             )
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // image: DecorationImage(
                //     image: networkHandler.getImage(addBlogModel!.id),
                //     fit: BoxFit.cover),
              ),
              child: Card(
                  child: ListTile(
                title: Text(addBlogModel!.title),
                subtitle: Text(addBlogModel!.body),
                leading: CircleAvatar(
                  radius: 18,
                  backgroundImage: networkHandler.getImage(addBlogModel!.id),
                  ),
                trailing:  Text("${addBlogModel!.duration.toString()} min"),
                ),
              )),
            
          ],
        ),
      ),
    );
  }
}
