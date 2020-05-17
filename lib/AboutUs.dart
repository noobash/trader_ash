import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:review_my_school/Loading.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('About Us'),
      ),
      body: Stack(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: Colors.white,),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 5.0, 0.0),
                  child: Text(
                    "We're on a mission :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                        color: Colors.pink),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("AppPages").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Loading();
                    else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 5.0, 5.0, 0.0),
                        child: Text(
                          snapshot.data.documents[0].data['description'],
                          style: TextStyle(fontSize: 15.0, color: Colors.teal),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                  child: Divider(
                    thickness: 5.0,
                    color: Colors.black87,
                  ),
                ),
                Center(
                  child: Text(
                    'If you still have any query , reach us at :',
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("AppPages").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Loading();
                    else {
                      return Center(
                        child: Text(snapshot.data.documents[0].data['contact'],
                          style: TextStyle(fontSize: 15.0, color: Colors.teal),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                  child: Container(
                    height: 270.0,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('images/school.jpg'),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
