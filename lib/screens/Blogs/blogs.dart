import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';
import 'package:carousel_pro/carousel_pro.dart';
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
  //AddBlogModel addBlogModel = AddBlogModel(body: '', coverImage: '', duration: 0, id: '', ingredients: '', procedure: '', productTypeName: '', title: '', username: '');
  final AddBlogModel? addBlogModel = AddBlogModel(body: '', coverImage: '', duration: 0, id: '', ingredients: [], procedure: '', productTypeName: '', title: '', isFavourite: false, isFeatured: false, username: '');
   List<AddBlogModel?>? data = [];
  int _currentIndex = 0;
  
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
        ? Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height*0.5,
                autoPlay: true,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: data!
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 10.0,
                          //bottom: 10.0,
                        ),
                        elevation: 0.0,
                        color: Colors.transparent,
                        shadowColor: Color(0xffe46b10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          child: Stack(
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
                          ],),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ]
        )
        : Center(
            child: Text("We don't have any recipe blogs Yet"),
          );
  }
}