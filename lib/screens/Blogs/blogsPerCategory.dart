import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_blog_app/CustumWidget/BlogCard.dart';
import 'package:recipe_blog_app/CustumWidget/BlogPerCategoryCard.dart';
import 'package:recipe_blog_app/Model/SuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/screens/Blogs/blog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../apiHandler.dart';

class CategoryRecipes extends StatefulWidget {
  const CategoryRecipes(
      {Key? key, required this.url, required this.recipeCategory})
      : super(key: key);
  final String url;
  final String recipeCategory;
  @override
  _CategoryRecipesState createState() => _CategoryRecipesState();
}

class _CategoryRecipesState extends State<CategoryRecipes> {
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
    var response =
        await networkHandler.get(widget.url + "/${widget.recipeCategory}");
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:   MediaQuery.of(context).size.height,
       color: Color(0xffEEEEFF),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _title(),
          SizedBox(height: 20),
          data!.length > 0
                ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView(
                      children: data!
                          .map((item) => Column(
                                children: <Widget>[
                                  Material(
                                    //color: Color(0xffEEEEFF),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) => RecipeBlog(
                                                      addBlogModel: item,
                                                      networkHandler: networkHandler,
                                                    )));
                                      },
                                      child: BlogcategoryCard(
                                        addBlogModel: item,
                                        networkHandler: networkHandler,
                                      ),
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
                    child: Text("We don't have any recipe category blogs Yet",style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffe46b10),),
                )),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: widget.recipeCategory,
            style: GoogleFonts.tangerine(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color:Colors.black,
            ),
            ),
      ),
    );
  }
}
