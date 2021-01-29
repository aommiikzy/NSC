import 'package:flutter/material.dart';
import 'package:mu_dent/screens/patient/Appointment_Booking/booking2.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientBooking extends StatefulWidget {
  @override
  _PatientBookingState createState() => _PatientBookingState();
}

class _PatientBookingState extends State<PatientBooking> {
  final CollectionReference dentistCollection =
      FirebaseFirestore.instance.collection('Dentists');

  List<String> dentistList = [];
  
  // Radio value validator
  int selectedradio = 1;
  // Dentist Name specification identifier
  bool isSpecify = true;

  String appointmentType = ""; 
  String dentistName = "";

  // DropdownFormField validator & controller
  final pickedAppointmentType = TextEditingController();
  final pickedDentistName = TextEditingController();

  CollectionReference patientCollection = 
    FirebaseFirestore.instance.collection('Patients');
  FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, String> e = {
    "02": "Bond",
    "03": "Band",
    "04": "Bond/Band",
    "05": "Bond",
    "08": "Bond",
    "10": "Bond",
    "15": "Bond",
    "21": "Bond",
    "60": "Bond",
    "68": "Bond",
    "69": "Bond",
    "81": "Bond",
    "109": "Bond",
    "208": "Bond",
    "215": "Bond",
    "216": "Bond",
    "226": "Bond",
    "227": "Bond",
    "241": "Bond",
    "334": "Bond",
  };
  
  List<String> appointmentTypeList = [
    "Bond",
    "Band",
    "Bond/Band",
    "Debond/Deband",
    "Insert RTN",
    "Insert Orthodontic tools",
    "New (Orthodontic)",
    "Observer",
    "Recheck RTN",
    "Detach tool + put RTN",
    "Detach wire to SC",
    "Emergency",
    "Diagnosis & Treatment Planning",
    "Insert Rubber",
    "Tighten the tool",
    "Loosen the tool",
    "Print teeth template",
    "Print teethh templete [RTN]",
    "Try Band",
    "Scan",
  ];

  Future<void> getDentistNames() async {
    // await patientCollection.doc(auth.currentUser.uid).get().then((DocumentSnapshot querysnap) {
    //   if (!querysnap.exists) {
    //     print('Not found!');
    //   } else {
    //     print('Found!');
    //   }
    // });

    // List<String> den = [];
    await dentistCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        // print(result.data()['Name'].toString() + " " + result.data()['Surname'].toString());
        // print(result.data()['Surname']);
        String name = result.data()['Name'].toString() +
            " " +
            result.data()['Surname'].toString();
        // print(name);
        dentistList.add(name);
      });
    });
    // Map<String, List<String>> operationPeriod =
    //   {
    //     'Monday': ['09:00-09:15', '09:15-09:30', '09:30-09:45', '09:45-10:00', 
    //         '10:00-10:15', '10:15-10:30', '10:30-10:45', '10:45-11:00'],
    //     'Tuesday': ['13:00-13:15', '13:15-13:30', '13:30-13:45', '13:45-14:00', 
    //         '14:00-14:15', '14:15-14:30', '14:30-14:45', '14:45-15:00'],
    //     'Wednesday': ['09:00-09:15', '09:15-09:30', '09:30-09:45', '09:45-10:00', 
    //         '10:00-10:15', '10:15-10:30', '10:30-10:45', '10:45-11:00'],
    //     'Thursday': ['13:00-13:15', '13:15-13:30', '13:30-13:45', '13:45-14:00', 
    //         '14:00-14:15', '14:15-14:30', '14:30-14:45', '14:45-15:00'],
    //     'Friday': ['09:00-09:15', '09:15-09:30', '09:30-09:45', '09:45-10:00', 
    //         '10:00-10:15', '10:15-10:30', '10:30-10:45', '10:45-11:00'],     
    //   };
    // await dentistCollection.add({
    //   'Name': 'Martin',
    //   'Surname': 'William',
    //   'Operation Period': operationPeriod,
    //   'Role': 'Dentist',
    // });
    // print(den);
  }

  @override
  void initState() {
    getDentistNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: colorDarkPurple,
        title: Text('Appointment Booking'),
      ),
      body: SingleChildScrollView(
              child: Stack(
                children: 
                <Widget>[Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.03, horizontal: size.width * 0.02),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Step 1: \nAppointment & Dentist Information',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: colorDarkPurple,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Appointment Type',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: colorDarkPurple,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownSearch<String>(
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(size.width * 0.03, 3, 0, 3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: appointmentTypeList,
                      showSearchBox: true,
                      hint: 'Select an appointment type',
                      onChanged: (val) {
                        print(val);
                        appointmentType = val;
                      },

                    ),
                    // DropDownField(
                    //   controller: pickedAppointmentType,
                    //   hintText: 'Select an appointment type',
                    //   enabled: true,
                    //   itemsVisibleInDropdown: 4,
                    //   items: appointmentTypeList,
                    //   strict: true,
                    //   required: true,
                    // ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Dentist Name',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: colorDarkPurple,
                      ),
                    ),
                    RadioListTile(
                      activeColor: colorDarkPurple,
                      title: Text("Specify a dentist's name", style: TextStyle(fontSize: 14),),
                      value: 1,
                      groupValue: selectedradio,
                      onChanged: (val) {
                        setState(() {
                          selectedradio = val;
                          isSpecify = true;
                          pickedDentistName.text = "";
                        });
                      },
                    ),
                    // SizedBox(height: size.height * 0.02,),
                    RadioListTile(
                      activeColor: colorDarkPurple,
                      title: Text("Do not specify a dentist's name",style: TextStyle(fontSize: 14),),
                      value: 2,
                      groupValue: selectedradio,
                      onChanged: (val) {
                        setState(() {
                          selectedradio = val;
                          isSpecify = false;
                          pickedDentistName.text = "Not specified";
                        });
                      },
                    ),
                    isSpecify
                        // ? DropDownField(
                        //     controller: pickedDentistName,
                        //     hintText: 'Select a dentist name',
                        //     enabled: true,
                        //     strict: true,
                        //     required: true,
                        //     itemsVisibleInDropdown: 4,
                        //     items: dentistList,
                        //   )
                        ? DropdownSearch<String>(
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(size.width * 0.03, 3, 0, 3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: dentistList,
                      showSearchBox: true,
                      hint: 'Select a dentist',
                      onChanged: (val) {
                        print(val);
                        dentistName = val;
                      },

                    )
                        : SizedBox(),
                    // SizedBox(height: size.height * 0.02),
                  ]
              )
          ),
        ]
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(25.0),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
          onPressed: () {
            if (appointmentType != '' &&
                dentistName != '') {
              print(appointmentType);
              print(dentistName);
              // appointment.name = citiesSelected2.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DateBooking(
                        appointmentType: appointmentType,
                        dentistName: dentistName)),
              );
            } else {
              print('error');
            }
          },
          color: colorGreen1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Next',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
