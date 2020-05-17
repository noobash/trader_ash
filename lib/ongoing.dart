import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Loading.dart';


class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  var selectedContest ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('States').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Loading();
            else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedContest = snapshot.data.documents[index].documentID;
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data.documents[index].documentID),
                      Divider(thickness: 3.0,)
                    ],
                  ),
                );
              });
            }
          }

      ),
    );
  }
}
