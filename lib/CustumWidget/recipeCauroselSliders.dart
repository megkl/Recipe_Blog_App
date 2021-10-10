import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';

import '../apiHandler.dart';

class RecipeCauroselSliders extends StatelessWidget {
  const RecipeCauroselSliders(
      {Key? key, required this.addBlogModel, required this.networkHandler})
      : super(key: key);

  final AddBlogModel? addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: addBlogModel!.coverImage.length,
      itemBuilder: (BuildContext context, int itemIndex) => Container(
        child: Image.asset(
          addBlogModel!.coverImage[itemIndex],
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 1.0,
        initialPage: 0,
      ),
    );

    // return Container(
    //   height: 100,
    //   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
    //   margin: EdgeInsets.only(left:5),
    //   width: MediaQuery.of(context).size.width * 0.22,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //       gradient: LinearGradient(
    //         colors: [
    //           const Color(0xffffff),
    //           const Color(0xffe46b10),
    //         ],
    //         begin: FractionalOffset.center,
    //         end: FractionalOffset.bottomCenter,
    //         stops: [0.0, 1.0],
    //         tileMode: TileMode.clamp,
    //       )),
    //   child: Card(
    //     elevation: 0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     color: Colors.transparent,
    //     child: Stack(
    //       children: <Widget>[
    //         ListTile(
    //             title: Container(
    //               height: MediaQuery.of(context).size.height,
    //               width: MediaQuery.of(context).size.width,
    //               padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: networkHandler
    //                       .getCategoriesImage(addBlogModel!.id),
    //                   alignment: Alignment.center,
    //                   //fit: BoxFit.scaleDown
    //                 ),
    //               ),
    //             ),
    //             subtitle: Text(
    //               addBlogModel!.title,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white,
    //                 fontSize: 14,
    //               ),
    //             ))
    //       ],
    //     ),
    //   ),
    // );
  }
}


//  var carouselSlider = CarouselSlider.builder(
//             itemCount: carouselimages.length,
//             itemBuilder: (BuildContext context, int itemIndex) => Container(
//               child: Image.asset(
//                 carouselimages[itemIndex],
//                 fit: BoxFit.fill,
//                 width: double.infinity,
//               ),
//             ),
//             options: CarouselOptions(
//               autoPlay: true,
//               enlargeCenterPage: true,
//               viewportFraction: 0.9,
//               aspectRatio: 1.0,
//               initialPage: 0,
//             ),
//           );
    