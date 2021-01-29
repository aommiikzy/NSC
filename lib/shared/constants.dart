import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorDarkPurple, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorDarkPurple, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorRed, width: 0.8),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorRed, width: 0.8),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
);

const dateSelectionBooking = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorRed, width: 0.8),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorRed, width: 0.8),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

const labelBookingPanel = TextStyle(
  fontFamily: 'OpenSans',
  // color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 18
);

const valueBookingPanel = TextStyle(
  fontFamily: 'OpenSans',
  color: colorDarkPurple,
  fontWeight: FontWeight.w700,
  fontSize: 16
);

// const menuBtn = ;

const registerLabel = TextStyle(
  fontSize: 16.0,
);

const listValueStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 15,
  fontWeight: FontWeight.w700,
  color: colorPurpleBlue
);

const listDateTimeStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 20,
  color: colorPurpleBlue,
  fontWeight: FontWeight.w800,
);

const labelAppDetailStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 17,
  color: Colors.black,
  
);

const valueApptDetailStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 16,
  fontWeight: FontWeight.w800,
  color: colorDarkPurple
);

const profileVal = TextStyle(
  fontFamily: 'OpenSans',
  color: colorDarkPurple,
  fontWeight: FontWeight.w700,
);

const profileLabel = TextStyle(
  fontFamily: 'OpenSans',
  color: Colors.black,

);

const notiHeaderStyle = TextStyle(
  fontFamily: 'OpenSans',
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

const notiContentStyle = TextStyle(
  fontFamily: 'OpenSans',  
);

const btnTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w600,
  fontSize: 16,
  color: Colors.white,
);

const calendarHintStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const colorDarkPurple = Color(0xFF701F62);
const colorGreen1 = Color(0xFF0ADD78);
const colorGreen2 = Color(0xFF09F058);
const colorRed = Color(0xFFFE3E3E);
const colorLightPurple = Color(0xFF8784F4);
const colorPurpleBlue = Color(0xFF532CBE);
const colorLightRed = Color(0xFFD85656);
const colorOrange = Color(0xFFF5D21B);