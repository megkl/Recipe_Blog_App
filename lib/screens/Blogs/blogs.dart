import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../apiHandler.dart';

class RecipeBlogs extends StatefulWidget {
  const RecipeBlogs({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _RecipeBlogsState createState() => _RecipeBlogsState();
}

class _RecipeBlogsState extends State<RecipeBlogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  //AddBlogModel addBlogModel = AddBlogModel(body: '', coverImage: '', duration: 0, id: '', ingredients: '', procedure: '', productTypeName: '', title: '', username: '');
  final AddBlogModel? addBlogModel = AddBlogModel(
      body: '',
      coverImage: '',
      duration: 0,
      id: '',
      ingredients: [],
      procedure: '',
      productTypeName: '',
      title: '',
      isFavourite: false,
      isFeatured: false,
      username: '');
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
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: data!
                  .map((item) => Column(
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
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          )
        : Center(
            child: Text("We don't have any Blog Yet"),
          );
  }
}
