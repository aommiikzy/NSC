import 'package:flutter/material.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/screens/notification/noti_detail.dart';
import 'package:mu_dent/screens/patient/View_Appointment/appointment_list_patient.dart';
import 'package:mu_dent/services/database.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:mu_dent/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mu_dent/screens/notification/notification.dart';
import 'package:mu_dent/screens/notification/noti_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userID = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: userID).patientData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorDarkPurple,
              // Hide Back Button
              automaticallyImplyLeading: false,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              'Welcome, \n ${snapshot.data.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28.0,
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20 / 2,
                        ),
                        height: 160,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/home/booking');
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(
                                height: 136,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.red[200],
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
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: colorLightRed,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 136,
                                  // our image take 200 width, thats why we set out total width - 200
                                  // width: size.width - 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                      // it use the available space
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20 * 1.5, // 30 padding
                                          vertical: 20 / 4, // 5 top and bottom
                                        ),
                                        // decoration: BoxDecoration(
                                        //   color: Color(0xFFFFA41B),
                                        //   borderRadius: BorderRadius.only(
                                        //     bottomLeft: Radius.circular(22),
                                        //     topRight: Radius.circular(22),
                                        //   ),
                                        // ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 20.0),
                                          child: Text(
                                            'Appointment Booking',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20 / 2,
                        ),
                        height: 160,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewAppointmentPatient(
                                          name: snapshot.data.name,
                                          surName: snapshot.data.surName,
                                        )));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAppointment()));
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(
                                height: 136,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.pink[100],
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
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE16CAA),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 136,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                      // it use the available space
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20 * 1.5, // 30 padding
                                          vertical: 20 / 4, // 5 top and bottom
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 20.0),
                                          child: Text(
                                            'View Appointments',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              'Upcoming Appointment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Color(0xFF7B08C2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20 / 2,
                        ),
                        height: 160,
                        child: InkWell(
                          // onTap: press,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(
                                height: 136,
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
                                        vertical: 19, horizontal: 20),
                                    margin: EdgeInsets.only(right: 10),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Appointment Type \n',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Dentist Name: \n',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                              ),
                                            ),
                                            Text(
                                              'Status: ',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('Date \n\n',style: TextStyle(
                                                fontFamily: 'OpenSans',
                                              ),),
                                            Text('Time',style: TextStyle(
                                                fontFamily: 'OpenSans',
                                              ),),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
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
      },
    );
  }
}

class NotiPage extends StatefulWidget {
  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<Noti> noti = [
    Noti(
        topic: 'Bond',
        content: 'this is a message ',
        date: '00/00/2222',
        time: '00:00',
        isImportant: true),
    Noti(
        topic: 'Band',
        content: 'this is a message ',
        date: '11/11/2222',
        time: '01:01',
        isImportant: false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: false,
        backgroundColor: colorDarkPurple,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: noti.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationDetail(
                            isImportant: noti[index].isImportant)));
              },
              leading: noti[index].isImportant
                  ? Icon(Icons.notification_important,
                      color: colorLightRed,
                      size: 30,
                    )
                  : null,
              title: Text(
                'Topic:  ${noti[index].topic}',
                style: notiHeaderStyle,
              ),
              subtitle: Text(
                  '${noti[index].content}\n' + 
                  '${noti[index].date} ${noti[index].time}',
                  style: notiContentStyle,
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
