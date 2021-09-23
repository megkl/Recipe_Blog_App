import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/CustumWidget/OverlayCard.dart';
import 'package:recipe_blog_app/Model/CategorySuperModel.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Model/recipeType.dart';
import 'package:recipe_blog_app/Pages/homepage.dart';
import 'package:recipe_blog_app/screens/Categories/recipeType.dart';
import 'package:http/http.dart' as http;
import '../../apiHandler.dart';

class AddBlog extends StatefulWidget {
  AddBlog({Key? key}) : super(key: key);
  //final String url;
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  TextEditingController _recipeType = TextEditingController();
  TextEditingController _duration = TextEditingController();
  TextEditingController _ingredients = TextEditingController();
  TextEditingController _procedure = TextEditingController();
  bool _isFeatured = false;
  bool _isFavourite = false;
  ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
  CategorySuperModel categorySuperModel = CategorySuperModel();
   List<RecipeTypeModel?>? data = [];
  //List<RecipeTypeModel> _categoryList = [];
  String selectedValue ="Pizza";
  List ingredients = [];
  String username = "";

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
  }
void getCategories() async {
    var response = await networkHandler.get("/productType/getProductType");
    categorySuperModel = CategorySuperModel.fromJson(response);
    setState(() {
      data = categorySuperModel.data;
      print(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
    checkProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (_imageFile!.path != null &&
                  _globalkey.currentState!.validate()) {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => OverlayCard(
                        imagefile: _imageFile,
                        title: _title.text,
                      )),
                );
              }
            },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            bodyTextField(),
            SizedBox(height: 20),
            recipeTypeTextField(),
            SizedBox(height: 20),
            // ingredientsTextField(),
            // SizedBox(height: 20),
            procedureTextField(),
            SizedBox(height: 20),
            durationTextField(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildFeaturesField(),
                ButtonTheme(
                  child: RaisedButton(
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    onPressed: () => _addFeatures(_ingredients.text),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: ingredients
                  .map(
                    (ingredient) => Card(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      ingredient,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
            addButton(),

          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value!.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe46b10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add Image and Title",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Color(0xffe46b10),
            ),
            onPressed: takeCoverPhoto,
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _body,
        validator: (value) {
          if (value!.isEmpty) {
            return "Body can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe46b10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide a body for Your Blog",
        ),
        maxLines: null,
      ),
    );
  }

  Widget recipeTypeTextField() {
    return DropdownButtonFormField(
      items: data!.map((item) {
        return new DropdownMenuItem(
            value: item!.productTypeName,
            child: Row(
              children: <Widget>[
                Icon(Icons.star),
                Text(item.productTypeName),
              ],
            ));
      }).toList(),
      onChanged: (value) {
        // do other stuff with _category
        setState(() => selectedValue = value.toString());
      },
      value: selectedValue,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          filled: true,
          fillColor: Colors.grey[200],
          //hintText: Localization.of(context).category,
          ),
    );
  }

  Widget ingredientsTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _ingredients,
        validator: (value) {
          if (value!.isEmpty) {
            return "Ingredients can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe46b10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide a ingredients for Your Blog",
        ),
        maxLines: null,
      ),
    );
  }

  Widget durationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _duration,
        validator: (value) {
          if (value!.isEmpty) {
            return "Duration cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe46b10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide a duration for Your Blog",
        ),
        maxLines: null,
      ),
    );
  }

  Widget procedureTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _procedure,
        validator: (value) {
          if (value!.isEmpty) {
            return "Procedure can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe46b10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Provide a procedure for Your Blog",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_imageFile != null && _globalkey.currentState!.validate()) {
          AddBlogModel addBlogModel = AddBlogModel(
              body: _body.text,
              title: _title.text,
              productTypeName: selectedValue,
              duration: int.parse(_duration.text),
              coverImage: '',
              id: '',
              ingredients: ingredients,
              username: "@$username",
              procedure: _procedure.text,
              isFeatured: _isFeatured,
              isFavourite: _isFavourite
              );
          var response =
              await networkHandler.post1("/product/Add", addBlogModel.toJson());
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            String id = json.decode(response.body)["data"];
            var imageResponse = await networkHandler.patchImage(
                "/product/add/coverImage/$id", _imageFile!.path);
            print(imageResponse.statusCode);
            if (imageResponse.statusCode == 200 ||
                imageResponse.statusCode == 201) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          }
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe46b10)),
          child: Center(
              child: Text(
            "Add Recipe Blog",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
   _buildFeaturesField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: _ingredients,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Ingredients'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _addFeatures(String text) {
    if (text.isNotEmpty) {
      setState(() {
        ingredients.add(text);
      });
      _ingredients.clear();
    }
  }
}
