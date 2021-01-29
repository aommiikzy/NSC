import 'package:flutter/material.dart';
import 'package:mu_dent/screens/patient/View_Appointment/postpone2.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:date_field/date_field.dart';

class PostPoneDate extends StatefulWidget {
  final String appointmentID;
  final String appointmentType;
  final String dentistName;
  final String patientName;

  PostPoneDate({this.appointmentID, this.appointmentType, this.dentistName, this.patientName});
  @override
  _PostPoneDateState createState() => _PostPoneDateState();
}

class _PostPoneDateState extends State<PostPoneDate> {

  DateTime selectedDate;
  String pickedDate = "";

  CollectionReference appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');

  CollectionReference dentistCollection =
      FirebaseFirestore.instance.collection('Dentists');

  Map<String, dynamic> operationPeriod =
      {}; // Map of operation period of selected dentist

  Map<dynamic, int> storedDay =
      {}; // Map of appointment days with max-limit per day

  List<dynamic> appointmentDays = [];

  DateTime _currentDate = DateTime.now(); // Current date

  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarCarousel _calendarCarousel;

  String error = ""; // Error messages
  bool errorStat = false; // Error status for button checking

  // The date that full with appointment will be replaced with eventIcon (Red Circle)
  // Red Icon
  static Widget unavailableIcon = new Container(
    decoration: new BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      // border: Border.all(color: Colors.red, width: 2.0)
    ),
  );

  // Green Icon
  static Widget availableIcon = new Container(
    decoration: new BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  // Orange
  static Widget fullIcon = new Container(
    decoration: new BoxDecoration(
      color: Color(0xFFF5D21B),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>();

  Future<void> _getOperationPeriod() async {
    await dentistCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        String name = result.data()['Name'].toString() +
            " " +
            result.data()['Surname'].toString();
        if (name == widget.dentistName.toString()) {
          print(result.id);
          // print(result.data()['Operation Period']);
          operationPeriod.addAll(result.data()['Operation Period']);
        }
      });
    });
  }

  Future<void> _getAppointmentDays() async {
    int count = 0;
    String name = "";
    String surname = "";

    List<String> n = [];
    n = widget.dentistName.split(' ');
    name = n[0];
    surname = n[1];

    // Get Specific dentist appointment
    // await appointmentCollection.where('DentistName', isEqualTo: 'Jarupak').
    // where('DentistSurname', isEqualTo: 'Srisuchat').get().then((querysnap) {
    //   querysnap.docs.forEach((element) {
    //     // print(element.data()['DateTime']);
    //     Timestamp a = element.data()['DateTime'];
    //     var b = DateTime.fromMillisecondsSinceEpoch(a.millisecondsSinceEpoch);
    //     String dateForm = DateFormat.yMMMd().format(b);
    //     print(dateForm);
    //   });
    // });

    // Get all appointmnets
    await appointmentCollection.where('DentistName', isEqualTo: name).
    where('DentistSurname', isEqualTo: surname).get().then((querysnapshot) {
      querysnapshot.docs.forEach((result) {
        // print(result.data()['Date']);
        // appointmentDays.add(result.data()['Date']);
        // print(result.data()['DateTime']);
        Timestamp a = result.data()['DateTime'];
        print(result.data()['DateTime']);
        var b = DateTime.fromMillisecondsSinceEpoch(a.millisecondsSinceEpoch);
        // String dateForm = DateFormat.yMMMd().format(b);
        var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(a.millisecondsSinceEpoch);
        String dateForm = DateFormat('d/M/yyyy').format(dateToTimeStamp);

        // String day = a.toDate().day.toString();
        // String month = a.toDate().month.toString();
        // String year = a.toDate().year.toString();
        // String dateForm = "$day/$month/$year";
        // print(dateForm);

        // if (!appointmentDays.contains(a.toDate())) {
        if (!appointmentDays.contains(dateForm)) {
          appointmentDays.add(dateForm);
          // appointmentDays.add(a.toDate());
          storedDay[dateForm] = count;
        } else {
          int c = 0;
          c = storedDay[dateForm];
          
          if (c < 10) {
            storedDay.update(dateForm, (value) => value = c+1);
          }
        }
      });
    });
  }

  void setCalendar() async {
    await _getOperationPeriod();

    // Get appointment days of selected dentist
    await _getAppointmentDays();

    storedDay.forEach((key, value) {
      print("$key = $value");

      // Split String of appointment date "D/M/YYYY" by '/'
      List<String> splitVal = [];
      splitVal = key.split('/');

      // Condition for UNAVAILABLE Appointment
      if(value == 10) {
        _markedDateMap.add(
          new DateTime(int.parse(splitVal[2]), int.parse(splitVal[1]), int.parse(splitVal[0])),
          new Event(
            date: new DateTime(int.parse(splitVal[2]), int.parse(splitVal[1]), int.parse(splitVal[0])),
            icon: unavailableIcon
          )
        );
      } 
      // Condition for FULL Appointment
      else if(value < 10) {
        _markedDateMap.add(
          new DateTime(int.parse(splitVal[2]), int.parse(splitVal[1]), int.parse(splitVal[0])),
          new Event(
            date: new DateTime(int.parse(splitVal[2]), int.parse(splitVal[1]), int.parse(splitVal[0])),
            icon: fullIcon
          )
        );
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    // Can add the red,green,yellow DATE in this state
    // By connecting with another class that handles the appointments on that day
    // Then return the day (DateTime FORMAT) that cannot book the appointment anymore along with the APPT_ID

    /// Add more events to _markedDateMap EventList

    setCalendar();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },

      onRightArrowPressed: () {
        setState(() {
          _targetDateTime =
              DateTime(_targetDateTime.year, _targetDateTime.month + 1);
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },

      onLeftArrowPressed: () {
        setState(() {
          _targetDateTime =
              DateTime(_targetDateTime.year, _targetDateTime.month - 1);
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },

      headerTextStyle: TextStyle(
          color: colorDarkPurple,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w600,
          fontSize: 20),

      leftButtonIcon: Icon(Icons.arrow_back_ios, color: colorDarkPurple),
      rightButtonIcon: Icon(Icons.arrow_forward_ios, color: colorDarkPurple),

      weekDayBackgroundColor: colorDarkPurple,
      weekdayTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'OpenSans',
      ),
      weekDayPadding: EdgeInsets.all(4),

      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),

      thisMonthDayBorderColor: Colors.grey,
      headerText: _currentMonth.toUpperCase(),
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: size.height * 0.44,
      selectedDateTime: _currentDate,
      showIconBehindDayText: true,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      isScrollable: false,

      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,

      selectedDayButtonColor: colorGreen1,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      todayTextStyle:
          TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,

      // markedDateCustomShapeBorder: CircleBorder(
      //   side: BorderSide(color: Colors.red)
      // ),
      markedDateCustomTextStyle: TextStyle(color: Colors.white),

      // Small dot of marked day under date button
      // markedDateMoreShowTotal: true,
    );



    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Re-Scheduling'),
        backgroundColor: colorDarkPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.037),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              Text(
                'Step 1: Date Selection',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: colorDarkPurple,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Available',
                      style: calendarHintStyle,
                    ),
                    Container(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: colorOrange,
                      ),
                    ),
                    Text(
                      'Full',
                      style: calendarHintStyle,
                    ),
                    Container(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: colorRed,
                      ),
                    ),
                    Text(
                      'Unavailable',
                      style: calendarHintStyle,
                    ),
                  ],
                ),
              ),
              
              Container(
                child: _calendarCarousel,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.04),
                child: Text('Date',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: colorDarkPurple)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0.8,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: size.width * 0.04),
                child: DateTimeFormField(
                  validator: ((val) => val.isAfter(DateTime(_currentDate.year,
                          _currentDate.month, _currentDate.day + 2))
                      ? null
                      : "Date must be after today for 2 days"),
                  onDateSelected: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                      // print(selectedDate.toString());
                      // print(date);
                      setState(() {
                        // String dMonth = "";
                        // if (selectedDate.month < 10) {
                        //   dMonth = "0${selectedDate.month}";
                        // } else {
                        //   dMonth = selectedDate.month.toString();
                        // }
                        pickedDate =
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        if(date.weekday == 6 || date.weekday == 7) {
                          error = "Slected date must be between Monday-Friday!";
                          errorStat = true;
                        } else if(storedDay.containsKey(pickedDate)) {
                          if (storedDay[pickedDate] == 10) {
                            error = "The selected day is unavailable!";
                            errorStat = true;
                          }
                        }
                        else {
                          error = "";
                          errorStat = false;
                        }
                        
                        print(pickedDate);
                      });
                    });
                  },
                  firstDate: DateTime.now(),
                  lastDate: DateTime(_currentDate.year + 1),
                  initialValue: DateTime(_currentDate.year, _currentDate.month,
                      _currentDate.day + 2),
                  decoration: dateSelectionBooking.copyWith(
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01,),
              // Error messages pop up
              Container(
                margin: EdgeInsets.only(left: size.width * 0.04),
                child: Text(
                  error,
                  style: TextStyle(
                    color: colorLightRed,
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(25.0),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
          onPressed: () {
            if (pickedDate != "" && !errorStat) {
              // print("pass");
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => PostPoneTime(
                      dentistName: widget.dentistName, 
                      appointmentType: widget.appointmentType,
                      pickedDate: selectedDate,
                    )));
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