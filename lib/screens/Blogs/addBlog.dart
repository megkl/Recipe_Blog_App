import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_blog_app/CustumWidget/OverlayCard.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import 'package:recipe_blog_app/Pages/homepage.dart';

import '../../apiHandler.dart';

class AddBlog extends StatefulWidget {
  AddBlog({Key? key}) : super(key: key);

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
  ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
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
            ingredientsTextField(),
            SizedBox(height: 20),
            procedureTextField(),
            SizedBox(height: 20),
            durationTextField(),
            SizedBox(
              height: 20,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _recipeType,
        validator: (value) {
          if (value!.isEmpty) {
            return "Product Type can't be empty";
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
          labelText: "Provide a body for Your Blog",
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
          AddBlogModel addBlogModel =
              AddBlogModel(body: _body.text, title: _title.text, productTypeName: '', duration: 0, coverImage: '', id: '', ingredients: '', username: '', procedure: '');
          var response = await networkHandler.post1(
              "/product/Add", addBlogModel.toJson());
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
              borderRadius: BorderRadius.circular(10), color: Color(0xffe46b10)),
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
}
