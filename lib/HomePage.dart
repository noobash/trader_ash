import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AboutUs.dart';
import 'Auth.dart';
import 'Loading.dart';
import 'ProductDetails.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    super.initState();
  }

  final List<String> goods = ['Grocery', 'Liquor', 'Fruits & Veggies'];
  var selectedGood;
  int selectedindex = 0;
  bool load = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: 'Log out',
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
            child: IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
              ),
              tooltip: "About Us",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ),
        ],
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 10, 0.0, 0.0),
          child: Text(
            'Trader Ash',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 90.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: goods.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedindex = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        child: Text(
                          goods[index],
                          style: TextStyle(
                            color: index == selectedindex
                                ? Colors.white
                                : Colors.white60,
                            fontSize: 18.0,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection(goods[selectedindex])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Loading();
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(snapshot
                                          .data.documents[index].documentID),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot
                                            .data.documents[index].data['url']),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedGood = snapshot
                                              .data.documents[index].documentID;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                        user: widget.user,
                                                        selectedGood:
                                                            selectedGood,
                                                        selectedIndex:
                                                            selectedindex,
                                                        selectedGoodIndex: index,
                                                        goods: goods,
                                                      )));
                                        });
                                      },
                                    ),
                                    Divider(
                                      thickness: 3.0,
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                    }),
              )),
            ],
          )),
    );
  }
}
