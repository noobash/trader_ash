import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:review_my_school/Auth.dart';
import 'package:review_my_school/DatabaseService.dart';
import 'package:review_my_school/Loading.dart';


class ProductDetails extends StatefulWidget {
  final User user;
  final int selectedGoodIndex;
  final String selectedGood;
  final int selectedIndex;
  final List<String> goods;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();

  ProductDetails(
      {this.user,this.selectedGoodIndex, this.selectedGood, this.selectedIndex, this.goods});
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(widget.goods[widget.selectedIndex])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Loading();
        else {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    tooltip: "Add to Wishlist",
                    onPressed: (){
                    },
                  ),
                ),
              ],
              title: Text(widget.selectedGood),
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Container(
                    height: 270.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot
                              .data.documents[widget.selectedGoodIndex].data['url']),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: Text(widget.selectedGood,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'INR ' ,
                        style: TextStyle(
                            color: Colors.black, fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(
                            text: snapshot.data.documents[widget.selectedGoodIndex].data['old price']  ,
                            style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black
                            )
                          ),
                          TextSpan(text: " " + snapshot.data.documents[widget.selectedGoodIndex].data['new price'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Colors.green, fontSize: 20),
                          ),
                          TextSpan(text: snapshot.data.documents[widget.selectedGoodIndex].data['unit'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green, fontSize: 20),)
                        ]
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

