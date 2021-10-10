import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      height: MediaQuery.of(context).size.height * 0.21,
      //padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: MediaQuery.of(context).size.width,
      //color: Colors.white,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.height * 0.22,
                  height: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        scale: 1,
                        image: networkHandler.getImage(addBlogModel!.id),
                        alignment: Alignment.center),
                    //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Positioned(
              bottom: 50,
              left: -100,
              child: Container(
                //height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: addBlogModel!.title,
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10),
                      ),
                      // children: [
                      //   TextSpan(
                      //     text: ' Recipes',
                      //     style: TextStyle(color: Colors.black, fontSize: 25),
                      //   ),
                      // ]
                      ),
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: -100,
              child: Container(
                //height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  addBlogModel!.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black45),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: -100,
              child: Container(
                //height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  ("${addBlogModel!.duration.toString()} mins"),
                  textAlign: TextAlign.center,
                  style:GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                        //color: Color(0xffe46b10),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
