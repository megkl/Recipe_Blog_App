import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_blog_app/Model/addBlogModels.dart';
import '../../apiHandler.dart';

class RecipeBlog extends StatelessWidget {
  @override
  const RecipeBlog(
      {Key? key, required this.addBlogModel, required this.networkHandler})
      : super(key: key);
  final AddBlogModel? addBlogModel;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    List<AddBlogModel> data = [];
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      body: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 0),
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffe46b10),
            image: DecorationImage(
              image: networkHandler.getImage(addBlogModel!.id),
              fit: BoxFit.cover,
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: .6,
          minChildSize: .6,
          maxChildSize: .8,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffEEEEFF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.drag_handle,
                              color: Colors.black38,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: addBlogModel!.title,
                                  style: GoogleFonts.portLligatSans(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffe46b10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.alarm),
                                    SizedBox(width: 5),
                                    Text(addBlogModel!.duration.toString()),
                                    Text(" mins"),
                                    SizedBox(width: 20),
                                    Icon(Icons.favorite, color: Colors.red),
                                    Text(" 20 likes")
                                  ])),
                          SizedBox(height: 24),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 24),
                          //   child: Text(
                          //     addBlogModel!.body,
                          //     maxLines: 3,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(
                          //       height: 1.5,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Text(
                              "Ingredients",
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffe46b10),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Wrap(children: <Widget>[
                              Container(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: addBlogModel!.ingredients
                                        .map(
                                          (item) => Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 110,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.food_bank, color: Color(0xffe46b10)),
                                                    Card(
                                                        elevation: 0,
                                                        color: Colors.transparent,
                                                        child: Center(
                                                            child: Text(item))),
                                                  ],
                                                ),
                                              )),
                                        )
                                        .toList()),
                              ))
                            ]),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                              child: Text("Procedure",
                                   style: GoogleFonts.portLligatSans(
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffe46b10),
                                  )),
                            ),
                          ),
                           Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                              child: Text(addBlogModel!.procedure,
                                   style: GoogleFonts.portLligatSans(
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  )),
                            ),
                          /*Container(
                        child: _buildLocation(
                          widget.data.positions,
                        ),
                      ),*/
                        ]),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Padding(
        //     padding:
        //         EdgeInsets.only(top: MediaQuery.of(context).size.height * .45),
        //     child: SliderIndicator(
        //       length: widget.properties.roomImages.length,
        //       activeIndex: 0,
        //       indicator: Icon(
        //         Icons.radio_button_checked,
        //         color: Colors.white,
        //         size: 10,
        //       ),
        //       activeIndicator: Icon(
        //         Icons.fiber_manual_record,
        //         color: Colors.white,
        //         size: 12,
        //       ),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 24, top: 45),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              left: 24,
              top: 50,
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.alarm,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 7),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: addBlogModel!.duration.toString(),
                      style: GoogleFonts.portLligatSans(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      children: [
                        TextSpan(
                          text: ' mins',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ]),
                ),
              ],
            ))
      ]),
    );
  }
}
