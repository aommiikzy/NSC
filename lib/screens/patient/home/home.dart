import 'package:flutter/material.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/screens/patient/View_Appointment/appointment_list_patient.dart';
import 'package:mu_dent/services/database.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:mu_dent/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mu_dent/screens/patient/pages.dart';
import 'package:mu_dent/screens/notification/notification.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    Center(
      child: Text('chat'),
    ),
    NotiPage()
  ];
  String userID = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    // Stream collectionStream = FirebaseFirestore.instance.collection('Patients').doc(userID).snapshots();

    // final user = Provider.of<UserData>(context);
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: tabs[_currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home,
                          color:
                              _currentIndex == 0 ? colorDarkPurple : null),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.message,
                          color:
                              _currentIndex == 1 ? colorDarkPurple : null),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications,
                          color:
                              _currentIndex == 2 ? colorDarkPurple : null),
                      label: '')
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
