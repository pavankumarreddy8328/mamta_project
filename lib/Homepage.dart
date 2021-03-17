import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String weight;
FirebaseFirestore firestore = FirebaseFirestore.instance;
class Homepage extends StatefulWidget{
  @override
  _HomepageState createState() {
    // TODO: implement createState
    return _HomepageState();
  }
}
class _HomepageState extends State<Homepage>{
  final formKey = new GlobalKey<FormState>();
  TextEditingController _numberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _numberController=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser(String weight) {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'weight': weight,
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    Future<void> _signOut(BuildContext context) async {
      try {

        await FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, '/Signinpage');

      } catch (e) {
        print(e);
      }
    }
    void _submit() {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        addUser(weight);
      }
    }

    return Scaffold(
          appBar: AppBar(
            title: Text('Weight Tracker'),
            actions: <Widget>[
              TextButton(
                child: Text('Logout',
                    style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () => _signOut(context),
              )
            ],
          ),
          body: ListView(
       children: <Widget>[
         Container(
           padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child:  Form(
              key: formKey,
              child: TextFormField(
                onSaved: (value){
                  weight = value;
                },
                controller: _numberController ,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.green,
                          width: 2,
                          style: BorderStyle.solid)

                  ),

                  labelText: "Enter Weight",
                  suffixIcon: Icon(
                    Icons.line_weight,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),

            Container(
              padding: EdgeInsets.fromLTRB(80.0, 10.0, 60.0, 0.0),
          child: ButtonTheme(
            child: ElevatedButton(
              onPressed: (){
                _submit();
              },
              child: Text(
                  'Save Weight'
              ),
            ),
          ),
        ),
         Container(
           padding: EdgeInsets.fromLTRB(80.0, 10.0, 60.0, 0.0),
           child: ElevatedButton(
             onPressed: (){
               Navigator.pushNamed(context, '/Database');
             },
             child:  Text(
                 'Show data'
             ),
           ),
         )
    ])

    );

  }
}



