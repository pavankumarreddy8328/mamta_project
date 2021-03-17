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

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 30.0,
            title: Text(
              'Weights',
              style: TextStyle(fontSize: 20.0,
              color: Colors.white),

            ),
          ),

            body: Card(
            child: ListView(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0,0.0),
          scrollDirection: Axis.vertical,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(

              hoverColor: Colors.blue,
              leading: Icon(
                Icons.desktop_mac_outlined,
                color: Colors.black,
              ),
              title: new Container(
                padding: EdgeInsets.all(20.0),
                  child: Text( 'Weight of '+users.id +':'+document.data()['weight'],
                  style: TextStyle(fontSize: 18.0,color: Colors.blue),
                  textAlign: TextAlign.center,)
              ),
            );
          }).toList(),
        )));
      },
    );
  }
}