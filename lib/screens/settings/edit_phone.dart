import 'package:flutter/material.dart';
import 'package:mu_dent/shared/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class editPhone extends StatefulWidget {
  @override
  _editPhoneState createState() => _editPhoneState();
  
}
 addNewPhone(id,phoneNumber) async {
  FirebaseFirestore.instance.collection('Patients').doc(id).update({
    'phoneNumber': phoneNumber,

  }); print("Updated already");
}

class _editPhoneState extends State<editPhone> {

final _controller = TextEditingController();
String phoneNumber;
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    print(user.uid);
  Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorDarkPurple,
        title: Text('Edit phone number'),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height *0.1,),
          Container(
            padding: EdgeInsets.fromLTRB(20.0,0,20,0),
            child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    // margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                    color: Colors.white,
                    elevation: 3.0,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      cursorColor: colorDarkPurple,
                    ),
                ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20,5,20,0),
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
              ),
              color: Color(0xFF09F058),
              child: FlatButton(
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  ),
                ),
                onPressed: (){
                  setState(() {
                    phoneNumber = _controller.text;
                    addNewPhone(user.uid,phoneNumber);
                  });
                },
              ),
            ) ,
          )
        ],
      ),
    );
  }
}