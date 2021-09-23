import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';

import '../apiHandler.dart';

class BlogCard extends StatelessWidget {
  const BlogCard(
      {Key? key, required this.addBlogModel, required this.networkHandler})
      : super(key: key);

  final AddBlogModel? addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: networkHandler.getImage(addBlogModel!.id),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 2,
              right: 3,
              left: 3,
              child: Container(
                padding: EdgeInsets.all(7),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffffff),
                        //const Color(0xffe46b10).withOpacity(0.7),
                       Colors.black.withOpacity(0.7)
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.center,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                child: Center(
                  child: Text(
                    addBlogModel!.title,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 3,
              right: 3,
              left: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                child: Center(
                  child: Text(
                    addBlogModel!.body,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
