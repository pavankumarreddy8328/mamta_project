import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GetUserName extends StatefulWidget{
  String documentId;
  @override
  _GetUserNameState createState() {
    // TODO: implement createState
    return _GetUserNameState(documentId);
  }
}

class _GetUserNameState extends State<GetUserName>{
  String documentId;
  _GetUserNameState(this.documentId);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Container(
                  child: Text(document['weight'])
              ),
            );
          }).toList(),
        );
      },
    );
  }
}