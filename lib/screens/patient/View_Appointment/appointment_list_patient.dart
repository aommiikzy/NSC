import 'package:flutter/material.dart';
import 'package:mu_dent/screens/patient/View_Appointment/appointment_detail_patient.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;

class ViewAppointmentPatient extends StatefulWidget {
  final String name;
  final String surName;

  ViewAppointmentPatient({this.name, this.surName});
  @override
  _ViewAppointmentPatientState createState() => _ViewAppointmentPatientState();
}

class _ViewAppointmentPatientState extends State<ViewAppointmentPatient> {
  String userID = FirebaseAuth.instance.currentUser.uid;
  String email = FirebaseAuth.instance.currentUser.email;

  List<String> formattedDate = [];

  final QuerySnapshot querySnapshot = null;
  List<Map<String, dynamic>> snapshotListData = <Map<String, dynamic>>[];
  QueryDocumentSnapshot resultPass = null;
  List<QueryDocumentSnapshot> resultNotFilter;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Query getName = FirebaseFirestore.instance.collection('Patients').);

  List<DocumentSnapshot> snapshots;

  Icon searchIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('');

  var items = List<String>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String surname = widget.surName;
    print("/${name} ${surname}/");
    Query query = FirebaseFirestore.instance
        .collection('Appointments')
        .orderBy('DateTime')
        .where('PatientName', isEqualTo: name)
        .where('PatientSurname', isEqualTo: surname);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      appBar: AppBar(
        elevation: 0,
        title: cusSearchBar,
        backgroundColor: colorDarkPurple,
      ),
      body: StreamBuilder(
        stream: query.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            resultNotFilter = snapshot.data.docs;
            print(resultNotFilter[0].data()['Date']);
            resultNotFilter.forEach((element) {
              String date = element.data()['Date'];
              DateTime fDate = DateTime.parse(date);
              print(DateFormat('d MMM y').format(fDate));
              formattedDate.add(DateFormat('d MMM y').format(fDate));
            });
            return ListOfAppointment(resultNotFilter);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView ListOfAppointment(resultNotFilter) {
    return SingleChildScrollView(
        child: Stack(children: <Widget>[
      Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
              child: Row(
                children: [
                  Text(
                    "Appointment list",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: colorLightPurple),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: resultNotFilter.length,
                  itemBuilder: (context, index) {
                    print("Send index = ${resultNotFilter[index].id}");

                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      // height: 136,
                      child: InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentDetailPatient(
                                    appointmentID: resultNotFilter[index].id),
                              ))
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            // Those are our background
                            Container(
                              // height: 136,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.grey[400],
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 15),
                                    blurRadius: 27,
                                    color: Colors
                                        .black12, // Black color with 12% opacity
                                  )
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  margin: EdgeInsets.only(right: 10),
                                  // width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: "Appointment Type \n",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  "   ${resultNotFilter[index]['AppointmentType']} \n",
                                              style: listValueStyle,
                                            )
                                          ])),
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: "Dentist name: ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    "${resultNotFilter[index]['DentistName']} \n",
                                                style: listValueStyle)
                                          ])),
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: "Status: ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    "${resultNotFilter[index]['Status']} ",
                                                style: listValueStyle)
                                          ])),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "${formattedDate[index]}\n",
                                                    style: listDateTimeStyle)
                                              ])),
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "${resultNotFilter[index]['Time'].toString().substring(0, 5)}  ",
                                                style: listDateTimeStyle)
                                          ])),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
