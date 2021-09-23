import 'package:flutter/material.dart';
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
    //List<String> ingredients = addBlogModel!.ingredients.split(',');
    List<AddBlogModel> data = [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: networkHandler.getImage(addBlogModel!.id),
              fit: BoxFit.fill,
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: .5,
          minChildSize: .5,
          maxChildSize: .8,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            padding: EdgeInsets.all(24),
                            child: Text(
                              addBlogModel!.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                /* _buildWidgetSize(
                                       "Living Room",
                                       widget.data.sizeLivingRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),
                                     _buildWidgetSize(
                                       "Bed Room",
                                       widget.data.sizeBedRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),
                                     _buildWidgetSize(
                                       "BathRoom",
                                       widget.data.sizeBathRoom,
                                     ),
                                     Container(
                                       width: 1,
                                       height: 50,
                                       color: Colors.black38,
                                     ),*/
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              addBlogModel!.body,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 150, top: 10, right: 0, bottom: 0),
                            child: Text(
                              "Features",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Wrap(children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent),
                                  child: Row(
                                      children: addBlogModel!.ingredients
                                          .map((item) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.blueAccent,
                                                    child: new Text(item)),
                                              ))
                                          .toList()))
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text("Read More",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  height: 1.5,
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
                  Icons.watch,
                  size: 16,
                  color: Colors.white,
                ),
                Text(
                  addBlogModel!.duration.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "min",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ))
      ]),
      // bottomNavigationBar: Container(
      //   child: RaisedButton(
      //     onPressed: () {
      //       customLaunch('tel:${widget.properties.sellerPhoneNumber}');
      //     },
      //     textColor: Colors.white,
      //     padding: const EdgeInsets.all(10.0),
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.all(Radius.circular(50.0)),
      //         gradient: LinearGradient(
      //           colors: <Color>[
      //             Color(0xFF0D47A1),
      //             Color(0xFF1976D2),
      //             Color(0xFF42A5F5),
      //           ],
      //         ),
      //       ),
      //       padding: const EdgeInsets.all(10.0),
      //       child: const Text('Contact Property Owner'),
      //     ),
      //   ),
      // ),
    );
    // return Scaffold(
    //   body: ListView(
    //     children: [
    //       Container(
    //         height: 365,
    //         width: MediaQuery.of(context).size.width,
    //         child: Card(
    //           elevation: 8,
    //           child: Column(
    //             children: [
    //               Container(
    //                 height: 230,
    //                 width: MediaQuery.of(context).size.width,
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                     image: networkHandler.getImage(addBlogModel!.id),
    //                     fit: BoxFit.fill,
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 10),
    //                 child: Text(
    //                   addBlogModel!.title,
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //                Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 10),
    //                 child: Text(
    //                   addBlogModel!.productTypeName,
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 10),
    //                 child: Column(
    //                   children: [
    //                     Icon(
    //                       Icons.chat_bubble,
    //                       size: 18,
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Text(
    //                       addBlogModel!.procedure.toString(),
    //                       style: TextStyle(fontSize: 15),
    //                     ),
    //                     SizedBox(
    //                       width: 15,
    //                     ),
    //                     Icon(
    //                       Icons.thumb_up,
    //                       size: 18,
    //                     ),
    //                     SizedBox(
    //                       width: 8,
    //                     ),
    //                     Text(
    //                       addBlogModel!.duration.toString(),
    //                       style: TextStyle(fontSize: 15),
    //                     ),
    //                     SizedBox(
    //                       width: 8,
    //                     ),
    //                     Padding(
    //                             padding: EdgeInsets.only(left: 150, top: 10, right: 0, bottom: 0),
    //                             child: Text(
    //                               "Features",
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 20,
    //                               ),),
    //                           ),
    //                           SizedBox(height: 50),
    //                     Container(
    //                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.transparent),
    //                       child: Row(
    //                         children: addBlogModel!.ingredients.map((item) => Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Container(
    //                             color: Colors.blueAccent,
    //                             child: new Text(item)),
    //                         )).toList()))
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         child: Card(
    //           elevation: 15,
    //           child: Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 10,
    //               vertical: 15,
    //             ),
    //             child: Text(addBlogModel!.body),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //);
  }
}
