import 'package:flutter/material.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:mu_dent/screens/settings/edit_phone.dart';
import 'package:mu_dent/shared/loading.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/services/database.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mu_dent/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> profileMenu = [
    'Name-Surname',
    'Gender',
    'Phone number',
    'Date of Birth',
    'Email'
  ];
  String userID = FirebaseAuth.instance.currentUser.uid;
  String email = FirebaseAuth.instance.currentUser.email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // signInWithGoogle();
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: colorDarkPurple,
                title: Text('Profile'),
              ),
              body: SingleChildScrollView(
                child: Stack(children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        // HN number
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('HN number'),
                            // subtitle: Text('${snapshot.data.name} ${snapshot.data.surName}',style: TextStyle(color:colorBtnDarkPurple,fontWeight: FontWeight.bold),),
                            subtitle: Text(
                              'HN0000',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // Name-Surname
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Name-Surname'),
                            subtitle: Text(
                              '${snapshot.data.name} ${snapshot.data.surName}',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // Gender
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Sex'),
                            subtitle: Text(
                              '${snapshot.data.gender}',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // Phone number
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Phone number'),
                            subtitle: Text(
                              '${snapshot.data.phoneNumber}',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // BoD
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Date of Birth'),
                            subtitle: Text(
                              '${snapshot.data.birthOfDate}',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // ID Card number
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Citizen ID Card Number'),
                            // subtitle: Text('${email}',style: TextStyle(color:colorBtnDarkPurple, fontWeight: FontWeight.bold),),
                            subtitle: Text(
                              '0123456789xxx',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        // Email
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: ListTile(
                            title: Text('Email'),
                            subtitle: Text(
                              '${email}',
                              style: profileVal,
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right),
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context){
                            //         return Profile();
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                        ),

                        RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return editPhone();
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          ),
                          color: Colors.white,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(15.0),
                          splashColor: colorDarkPurple,
                          child: Text(
                            "Edit phone number",
                            style: TextStyle(color: Color(0xFFFE3E3E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Scaffold here() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorDarkPurple,
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Name-Surname'),
              subtitle: Text(
                'asd',
                style: TextStyle(
                    color: colorDarkPurple, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Gender'),
              subtitle: Text(
                'asd',
                style: TextStyle(
                    color: colorDarkPurple, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Phone number'),
              subtitle: Text(
                'asd',
                style: TextStyle(
                    color: colorDarkPurple, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Date of Birth'),
              subtitle: Text(
                'asd',
                style: TextStyle(
                    color: colorDarkPurple, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Email'),
              subtitle: Text(
                'asd',
                style: TextStyle(
                    color: colorDarkPurple, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            elevation: 3.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return editPhone();
                  },
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(15.0),
            splashColor: colorDarkPurple,
            child: Text(
              "Edit phone number",
              style: TextStyle(color: Color(0xFFFE3E3E)),
            ),
          ),
        ],
      ),
    );
  }
}
