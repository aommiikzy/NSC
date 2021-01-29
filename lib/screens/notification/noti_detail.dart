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

class NotificationDetail extends StatefulWidget {
  final bool isImportant;
  NotificationDetail({this.isImportant});
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    bool isImportant = widget.isImportant;
    return Scaffold(
      appBar: AppBar(
        title: isImportant
            ? Text('Appointment Confirmation')
            : Text('Appointment Detail'),
        backgroundColor: colorDarkPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Appointment Number: ",
                  style: labelAppDetailStyle,
                ),
                TextSpan(
                    text: 'asd',
                    // text: "${widget.APTID}",
                    style: valueApptDetailStyle)
              ])),
              SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Appointment Type: ", style: labelAppDetailStyle),
                TextSpan(
                    text: 'asd',
                    // text: "${snapshot.data.docs[0]['AppointmentName']}",
                    style: valueApptDetailStyle)
              ])),
              SizedBox(
                height: 15,
              ),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Date: ",
                        style: labelAppDetailStyle,
                      ),
                      TextSpan(
                          text: 'asd',
                          // text: "${snapshot.data.docs[0]['Date']}",
                          style: valueApptDetailStyle)
                    ])),
                    SizedBox(
                      width: 20,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Time: ",
                        style: labelAppDetailStyle,
                      ),
                      TextSpan(
                          text: 'asd',
                          // text: "${snapshot.data.docs[0]['Time']}",
                          style: valueApptDetailStyle)
                    ]))
                  ]),
              SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Dentist Name: ",
                  style: labelAppDetailStyle,
                ),
                TextSpan(
                    text: 'asd',
                    // text: "${snapshot.data.docs[0]['DentistName']}",
                    style: valueApptDetailStyle)
              ])),
              SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Patient Name: ",
                  style: labelAppDetailStyle,
                ),
                TextSpan(
                    text: 'asd',
                    // text: "${snapshot.data.docs[0]['PatientName']}",
                    style: valueApptDetailStyle)
              ])),
              SizedBox(
                height: 15,
              ),
              Text("Details ", style: labelAppDetailStyle),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 9,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TextField(
                  // textAlign: TextAlign.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    // contentPadding:
                    //     const EdgeInsets.symmetric(vertical: 60),
                    hintText: 'Details...',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              isImportant
                  ? Column(
                      children: [
                        Center(
                          child: RaisedButton(
                            elevation: 3.0,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: colorGreen1,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 4),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Confirm",
                                style: btnTextStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RaisedButton(
                            elevation: 3.0,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: colorLightRed,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 4),
                            splashColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Decline",
                                style: btnTextStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(),
            ],
          ),
        ),
      ),
    );
  }
}
