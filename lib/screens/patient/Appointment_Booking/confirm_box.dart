import 'package:flutter/material.dart';
import 'package:mu_dent/models/appointment.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;

class ConfirmationPanel extends StatefulWidget {

  final String dentistName;
  final String appointmentType;
  final String patientName;
  final DateTime dateTime;
  final String dentistID;
  final String patientID;
  
  ConfirmationPanel({
    this.dentistName, 
    this.appointmentType, 
    this.patientName, 
    this.dateTime,
    this.dentistID,
    this.patientID
    });

  @override
  _ConfirmationPanelState createState() => _ConfirmationPanelState();
}

class _ConfirmationPanelState extends State<ConfirmationPanel> {

  CollectionReference patientCollection = 
    FirebaseFirestore.instance.collection('Patients');
  CollectionReference appointmentCollection = 
    FirebaseFirestore.instance.collection('Appointments');

  String dentistID = "";
  String dentistName = "";
  String dentistSurname = "";
  String appointmentType = "";
  String patientID = "";
  String patientName = "";
  String patientSurname = "";
  String dates;
  String times;
  Timestamp dateTime;
  String docName = "";

  final dateFormat = DateFormat('yyyy-M-dd');
  final timeFormat = DateFormat('hh:mm');

  Future<void> createAppointment() async {
    int docLenght = 0;
    QuerySnapshot _myDoc = await appointmentCollection.get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    print(_myDocCount.length);  // Count of Documents in Collection

    docLenght = _myDocCount.length+1;
    if(docLenght < 10) {
      docName = "APT000$docLenght";
    } else if(docLenght < 100) {
      docName = "APT00$docLenght";
    } else if(docLenght < 1000) {
      docName = "APT0$docLenght";
    } else {
      docName = "APT$docLenght";
    }

    // docName = docLenght < 10 
    //   ? "APT0$docLenght"
    //   : "APT$docLenght";

    print(docName);

    return await appointmentCollection.doc(docName).set({
      'AppointmentID': docName,
      'AppointmentType': appointmentType,
      'Date': dates,
      'Time': times,
      'DateTime': dateTime,
      'DentistID': dentistID,
      'DentistName': dentistName,
      'DentistSurname': dentistSurname,
      'Detail': '-',
      'PatientID': widget.patientID,
      'PatientName': patientName,
      'PatientSurname': patientSurname,
      'Status': "Pending",
      'Venue': 'Building 1'
    }).then((value) {
      print('Created');
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }).
    catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    String name = "";
    String surname = "";
    List<String> splited = [];
    int index = 0;

    index = widget.dentistName.indexOf(" ");
    print("asd");
  
    dentistID = widget.dentistID;
    dentistName = widget.dentistName.substring(0, index);
    dentistSurname = widget.dentistName.substring(index+1);
    print("$dentistName $dentistSurname");

    appointmentType = widget.appointmentType;

    index = widget.patientName.indexOf(" ");

    patientID = widget.patientID;
    patientName = widget.patientName.substring(0, index);
    patientSurname = widget.patientName.substring(index+1);
    print("$patientName$patientSurname");

    dateTime = Timestamp.fromDate(widget.dateTime);

    print(DateFormat.yMMMMd().format(widget.dateTime));

    dates = DateFormat('yyyy-MM-dd').format(widget.dateTime);
    print(dates);
    print(DateFormat('dd/MM/yyyy').format(widget.dateTime));

    times = DateFormat('HH:mm').format(widget.dateTime);
    print(times);
    // print(dateTime);
    // print(widget.dateTime.millisecondsSinceEpoch); Timestamp

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // color: Colors.amber,

      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                'Information Confirmation',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: colorDarkPurple),
              ),
            ),
            // SizedBox(height: size.height * 0.00002),
            Row(
              children: [
                Text(
                  'Dentist Name',
                  style: labelBookingPanel,
                ),
                SizedBox(width: size.width * 0.015),
                Text(
                  "${dentistName} ${dentistSurname}",
                  style: valueBookingPanel,
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.002),
            Row(
              children: [
                Text(
                  'Appointment Type',
                  style: labelBookingPanel,
                ),
                SizedBox(width: size.width * 0.015),
                Text(
                  appointmentType,
                  style: valueBookingPanel,
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Text(
                  'Patient Name',
                  style: labelBookingPanel,
                ),
                SizedBox(width: size.width * 0.015),
                Flexible(
                  child: Container(
                    child: Text(
                      "$patientName $patientSurname",
                      style: valueBookingPanel,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.02),
            Row(
              children: <Widget>[
                Text(
                  'Date',
                  style: labelBookingPanel,
                ),
                Text(
                  '  ${DateFormat.yMMMMd().format(widget.dateTime)}   ',
                  style: valueBookingPanel,
                ),
                // SizedBox(width: size.width * 0.01),
                Text(
                  'Time',
                  style: labelBookingPanel,
                ),
                Text(
                  '  ${DateFormat.Hm().format(widget.dateTime)}',
                  style: valueBookingPanel,
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.02),
            Row(
              children: <Widget>[
                Text(
                  'Venue',
                  style: labelBookingPanel,
                ),
                Text(
                  '  Building 1',
                  style: valueBookingPanel,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      createAppointment();

                    },
                    color: colorGreen1,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: colorLightRed,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
