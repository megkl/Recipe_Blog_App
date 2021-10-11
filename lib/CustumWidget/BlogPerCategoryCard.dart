import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      height: MediaQuery.of(context).size.height*0.13,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: MediaQuery.of(context).size.width,
      color: Color(0xffEEEEFF),
      child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Card(
                elevation: 0,
                //color: Colors.transparent,
                child: Center(
                  child: ListTile(
                  title: _title(),
                  subtitle:  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("How to make ${addBlogModel!.title} in ${addBlogModel!.duration.toString()} mins"),
                      
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    backgroundImage: networkHandler.getImage(addBlogModel!.id),
                    ),
                  trailing:  Icon(Icons.arrow_forward_sharp, color: Colors.black)
                  ),
                ),
              )),
            
          ],
        ),
    );
  }
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
          text: addBlogModel!.title,
          style: GoogleFonts.portLligatSans(
            //textStyle: Theme.of(context).textTheme.display1,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          ),
    );
  }

}
