import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mu_dent/screens/patient/Appointment_Booking/confirm_box.dart';
import 'package:mu_dent/screens/patient/View_Appointment/postpone_confirm.dart';
import 'package:mu_dent/shared/constants.dart';

class PostPoneTime extends StatefulWidget {
  final String dentistName;
  final String appointmentType;
  final DateTime pickedDate;

  PostPoneTime({this.dentistName, this.appointmentType, this.pickedDate});
  @override
  _PostPoneTimeState createState() => _PostPoneTimeState();
}

class _PostPoneTimeState extends State<PostPoneTime> {

  DateTime pickedDate; // Global variable for initial pickedDate
  DateTime pickedDateTime; // Global variable for final pickedDateTime
  String pickedWeekDay = ""; // Weekday (1-Monday, 2-Tuesday, 3-Wednesday, 4-Thursday, 5-Friday)
  final formatter = DateFormat('yyyy-MM-dd hh:mm:ss');

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference patientCollection = 
    FirebaseFirestore.instance.collection('Patients');
  CollectionReference appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');
  CollectionReference dentistCollection =
      FirebaseFirestore.instance.collection('Dentists');

  final f = DateFormat('yyyy-M-dd');

  List<int> selectedIndexList = new List<int>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  Map<String, dynamic> operationPeriod =
      {}; // Map of operation period of selected dentist

  bool pressAction = false; // Press status in gridView

  List<dynamic> timeSlots2 = []; // Operation Period on selected day

  List<String> reservedTime = []; // Reserved time

  List<String> availableTime = []; // Final time slot list in GridView

  final List<String> timeSlots = [
    '10:00-10:15',
    '10:15-10:30',
    '10:30-10:45',
    '10:45-11:00',
    '13:00-13:15',
    '10:00-10:15',
    '10:15-10:30',
    '10:30-10:45',
    '10:45-11:00',
    '13:00-13:15',
  ];

  String currentPickedTime;

  final _formKey = GlobalKey<FormState>();

  String dentistID = "";
  String patientName = "";
  String patientID = "";

  Future<void> _getOperationPeriod() async {
    String name = "";
    String surname = "";

    List<String> n = [];
    n = widget.dentistName.split(' ');
    name = n[0];
    surname = n[1];
    // print("$name / $surname");

    await dentistCollection.where('Name', isEqualTo: name).
    where('Surname', isEqualTo: surname).get().then((querysnap) {
      querysnap.docs.forEach((element) {
        dentistID = element.id;
      });
    });

    print(dentistID);

    
    await dentistCollection.doc(dentistID).get().then((DocumentSnapshot querysnap) {
      // print(querysnap.data()['Operation Period']);
      operationPeriod.addAll(querysnap.data()['Operation Period']);
    });

    // print(operationPeriod);

    operationPeriod.forEach((key, value) {
      if(key == pickedWeekDay) {
        timeSlots2.addAll(value);
      }
    });
  }

  Future<void> _getAppointmentTime() async {
    String name = "";
    String surname = "";

    String hourPeriod = "";
    String minutePeriod = "";

    List<String> n = [];
    n = widget.dentistName.split(' ');
    name = n[0];
    surname = n[1];

    print(DateFormat('d/M/yyyy').format(pickedDate));

    await appointmentCollection.
    where('DentistName', isEqualTo: name).
    where('DentistSurname', isEqualTo: surname).
    get().
    then((querysnapshot) {
      querysnapshot.docs.forEach((element) {
        Timestamp a = element.data()['DateTime'];
        var b = DateTime.fromMillisecondsSinceEpoch(a.millisecondsSinceEpoch);
        // String dateForm = DateFormat.yMMMd().format(b);
        var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(a.millisecondsSinceEpoch);
        String dateForm = DateFormat('d/M/yyyy').format(dateToTimeStamp);
        
        // print(DateFormat('d/M/yyyy HH:mm').format(dateToTimeStamp));
        print(DateFormat('d/M/yyyy').format(dateToTimeStamp));
        // print(DateFormat('d/M/yyyy').format(pickedDate));
        if(DateFormat('d/M/yyyy').format(dateToTimeStamp) == DateFormat('d/M/yyyy').format(pickedDate)) {
          if(dateToTimeStamp.minute+15 == 60) {
            hourPeriod = "${dateToTimeStamp.hour + 1}";
            minutePeriod = "00";
          } else {
            hourPeriod = dateToTimeStamp.hour.toString();
            minutePeriod = "${dateToTimeStamp.minute + 15}";
          }
          // hourPeriod = "${dateToTimeStamp.hour}:${dateToTimeStamp.minute+15}";
          String formattedTime = DateFormat('HH:mm').format(dateToTimeStamp);
          // String formattedTime = "${dateToTimeStamp.hour}:${dateToTimeStamp.minute}";
          String finalVal = "$formattedTime-$hourPeriod:$minutePeriod";
          // print(finalVal);
          reservedTime.add(finalVal);
        }
      });
    });
    print("reserved: $reservedTime");
  }

  Future<void> _compareTimeSlots () {
    timeSlots2.forEach((element) {
      if(!reservedTime.contains(element)) {
        availableTime.add(element);
      }
    });
    print("available: $availableTime");
  }

  void setTimeSlots() async {
    await _getOperationPeriod();
    await _getAppointmentTime();
    await _compareTimeSlots();

    setState(() {
      
    });

    String name;
    String surname;

    await patientCollection.doc(auth.currentUser.uid).get().then((DocumentSnapshot snapshot) {
      name = snapshot.data()['name'];
      surname = snapshot.data()['surName'];
      patientID = auth.currentUser.uid;
    });

    patientName = "$name $surname";
  }

  @override
  void initState() {

    pickedDate = widget.pickedDate;
    print(pickedDate);
    switch (pickedDate.weekday) {
      case 1:
        pickedWeekDay = "Monday";
        break;
      case 2:
        pickedWeekDay = "Tuesday";
        break;
      case 3:
        pickedWeekDay = "Wednesday";
        break;
      case 4:
        pickedWeekDay = "Thursday";
        break;
      case 5:
        pickedWeekDay = "Friday";
        break;
      default:
        pickedWeekDay = "NaN";
    }
    
    setTimeSlots();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color timeBtnColor = Colors.white;
    Size size = MediaQuery.of(context).size;
    String pickedTime = ""; // Selected time slot

    void _showConfirmationBox() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          builder: (context) {
            Size size = MediaQuery.of(context).size;
            return Container(
              // color: Color(0xFF737373),

              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.009, horizontal: size.width * 0.02),
              child: PostPoneConfirm(
                dentistName: widget.dentistName,
                appointmentType: widget.appointmentType,
                patientName: patientName,
                dateTime: pickedDateTime,
                dentistID: dentistID,
                patientID: patientID
              ),
            );
          });
    }

    List<Widget> _getTiles(List<String> iconList) {
      List<int> selectedIndexList = new List<int>();
      final List<Widget> tiles = <Widget>[];
      for (int i = 0; i < timeSlots.length; i++) {
        tiles.add(new GridTile(
            child: Container(
          // height: size.height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(timeSlots[i]),
            onPressed: () {
              print('clicked');
              // if(selectedIndexList.length != 0) {
              //   selectedIndexList.clear();
              // }
              if (!selectedIndexList.contains(i)) {
                selectedIndexList.add(i);
              } else {
                selectedIndexList.remove(i);
              }
              setState(() {});
            },
            color: selectedIndexList.contains(i)
                ? colorDarkPurple
                : Colors.white,
            // onPressed: () {
            //   print(timeSlots[i]);
            //   setState(() {
            //     pressAction = true;
            //     // timeBtnColor = colorBtnDarkPurple;
            //   });
            // },
          ),
        )));
      }
      return tiles;
    }

    return Scaffold(
      backgroundColor: Color(0XFFF5F5F5),
      appBar: AppBar(
        title: Text('Appointment Re-Schedule'),
        backgroundColor: colorDarkPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
            // height: size.height * 1,
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03, horizontal: size.width * 0.03),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Step 2: Time Selection',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: colorDarkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: colorDarkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 12),
                          blurRadius: 15,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          DateFormat.yMMMMd().format(pickedDate),
                          // "${widget.pickedDate.day}/${widget.pickedDate.month}/${widget.pickedDate.year}",
                          style: valueBookingPanel,
                        )),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Available Time',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: colorDarkPurple,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Container(
                    height: size.height * 0.4,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2),
                      scrollDirection: Axis.vertical,
                      itemCount: availableTime.length,
                      itemBuilder: (context, index) {
                        return Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndexList.contains(index)
                                      ? colorDarkPurple
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(17.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 12),
                                      blurRadius: 15,
                                      spreadRadius: -5,
                                    ),
                                  ],
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      if (!selectedIndexList.contains(index)) {
                                        selectedIndexList.clear();
                                        selectedIndexList.add(index);
                                        // print(index);
                                        pickedTime = availableTime[index];
                                        print(pickedTime);
                                      } else {
                                        selectedIndexList.remove(index);
                                      }
                                    });
                                    int ind = pickedTime.indexOf("-");
                                    // print(pickedTime);
                                    String dateTime = pickedTime.substring(0, ind);
                                    // String month = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    String hour = dateTime.substring(0, 2);
                                    String minute = dateTime.substring(3);
                                    // print("$hour:$minute");
                                    // print(dateTime);
                                    String finale = "";
                                    DateTime dd;
                                    // pickedDate = DateTime(pickedDate.hour+);
                                    finale = "${pickedDate.year}-${DateFormat('MM').format(pickedDate)}-${pickedDate.day} $hour:$minute:00.000";
                                    // print(pickedDate);
                                    // print(finale);
                                    pickedDateTime = formatter.parse(finale);
                                    // print(pickedDateTime);
                                  },
                                  color: selectedIndexList.contains(index)
                                      ? colorDarkPurple
                                      : Colors.white,
                                  // padding: EdgeInsets.symmetric(horizontal: 65.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(17))),
                                  child: selectedIndexList.contains(index)
                                      ? Text(
                                          availableTime[index],
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          availableTime[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w600),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // child: GridView.count(
                    //   crossAxisCount: 3,
                    //   childAspectRatio: 3.0,
                    //   padding: const EdgeInsets.all(4.0),
                    //   mainAxisSpacing: 10.0,
                    //   crossAxisSpacing: 10.0,
                    //   shrinkWrap: true,
                    //   children: _getTiles(timeSlots),
                    // ),
                  )
                ])),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(25.0),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
          onPressed: () {
            _showConfirmationBox();
          },
          color: colorGreen1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Book',
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