import 'package:flutter/material.dart';
import 'package:mu_dent/screens/patient/View_Appointment/postpone1.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;


class AppointmentDetailPatient extends StatefulWidget {

  final String appointmentID;

  AppointmentDetailPatient({this.appointmentID});
  @override
  _AppointmentDetailPatientState createState() =>
      _AppointmentDetailPatientState();
}

class _AppointmentDetailPatientState extends State<AppointmentDetailPatient> {

  String formattedDate = "";

  @override
  Widget build(BuildContext context) {

    Query query = FirebaseFirestore.instance
        .collection('Appointments')
        .where('AppointmentID', isEqualTo: widget.appointmentID);

    print("get = ${widget.appointmentID}");
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text("Appointment Detail"),
        centerTitle: true,
        backgroundColor: colorDarkPurple,
      ),
      body: StreamBuilder(
        stream: query.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            String date = snapshot.data.docs[0]['Date'];
            DateTime fDate = DateTime.parse(date);
            print(DateFormat('d MMMM y').format(fDate));
            formattedDate = DateFormat('d MMMM y').format(fDate);

            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Appointment Number: ",
                        style: labelAppDetailStyle
                      ),
                      TextSpan(
                          text: "${widget.appointmentID}",
                          style: valueApptDetailStyle)
                    ])),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Appointment Type: ",
                        style: labelAppDetailStyle
                      ),
                      TextSpan(
                          text: "${snapshot.data.docs[0]['AppointmentType']}",
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
                              style: labelAppDetailStyle
                            ),
                            TextSpan(
                                text: formattedDate,
                                style: valueApptDetailStyle)
                          ])),
                          SizedBox(
                            width: 20,
                          ),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: "Time: ",
                              style: labelAppDetailStyle
                            ),
                            TextSpan(
                                text: "${snapshot.data.docs[0]['Time']}",
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
                        style: labelAppDetailStyle
                      ),
                    ])),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "     ${snapshot.data.docs[0]['DentistName']} ${snapshot.data.docs[0]['DentistSurname']}",
                          style: valueApptDetailStyle)
                    ])),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Patient Name: ",
                        style: labelAppDetailStyle
                      ),
                      
                    ])),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "     ${snapshot.data.docs[0]['PatientName']} ${snapshot.data.docs[0]['PatientSurname']}",
                          style: valueApptDetailStyle)
                      ])
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Details ",
                        style: labelAppDetailStyle),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15,
                            offset: const Offset(0, 10),
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
                    Center(
                        child: RaisedButton(
                      elevation: 3.0,
                      onPressed: () {
                        String dentistName = "${snapshot.data.docs[0]['DentistName']} ${snapshot.data.docs[0]['DentistSurname']}";
                        String patientName= "${snapshot.data.docs[0]['PatientName']} ${snapshot.data.docs[0]['PatientSurname']}";
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PostPoneDate(
                            appointmentID: snapshot.data.docs[0]['AppointmentID'],
                            appointmentType: snapshot.data.docs[0]['AppointmentType'],
                            dentistName: dentistName,
                            patientName: patientName,
                          )));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      color: Colors.amber[800],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(5.0),
                      splashColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Re-Appointment",
                          style: btnTextStyle,
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 50,
                    ),

                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    
    );
  }
}
