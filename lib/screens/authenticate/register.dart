import 'package:flutter/material.dart';
import 'package:mu_dent/services/auth.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:date_field/date_field.dart';
import 'package:mu_dent/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int selectedradio;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;

  String hn = "";
  String name = "";
  String surName = "";
  String gender = "";
  String phoneNumber = "";
  String boD = "";
  String idCardNum = "";
  String email = "";
  String password = "";
  String confPassword = "";

  String error = "";

  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedradio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedradio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: colorDarkPurple,
              title: Text(
                'Registration',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.03),
                    width: size.width * 0.8,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // HN
                          Row(
                            children: <Widget>[
                              Text(
                                'Hospital Number (HN)',
                                style: registerLabel,
                              ),
                              Tooltip(
                                child: Icon(Icons.warning_outlined),
                                message: "If you do not know your HN number, \nplease contact 0123456789",
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'HN0000',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                ),

                                contentPadding: EdgeInsets.only(left: 20)
                              ),
                            cursorColor: colorDarkPurple,
                            validator: (val) =>
                                val.isEmpty ? 'Enter a hospital number' : null,
                            onChanged: ((val) => hn = val),
                          ),
                          SizedBox(height: size.height * 0.02),
                          // Name
                          Row(
                            children: <Widget>[
                              Text(
                                'Name',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(left: 20)),
                            cursorColor: colorDarkPurple,
                            validator: (val) =>
                                val.isEmpty ? 'Enter a name' : null,
                            onChanged: ((val) => name = val),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Surname
                          Row(
                            children: <Widget>[
                              Text(
                                'Surname',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Surname',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(left: 20)),
                            cursorColor: colorDarkPurple,
                            validator: (val) =>
                                val.isEmpty ? 'Enter a name' : null,
                            onChanged: ((val) => surName = val),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Gender
                          Row(
                            children: <Widget>[
                              Text(
                                'Sex',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: selectedradio,
                                activeColor: colorDarkPurple,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                              Text('Male'),
                              Radio(
                                value: 2,
                                groupValue: selectedradio,
                                activeColor: colorDarkPurple,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                              Text('Female')
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Phone number
                          Row(
                            children: <Widget>[
                              Text(
                                'Phone number',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: '0123456789',
                              hintStyle: TextStyle(
                                  color: colorDarkPurple,
                                  fontStyle: FontStyle.italic),
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                            cursorColor: colorDarkPurple,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter phone numbers';
                              }
                              if (val.length < 10 || val.length > 10) {
                                return 'Phone number length must be 10 characters';
                              }
                              return null;
                            },
                            onChanged: ((val) => phoneNumber = val),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Birth of Date
                          Row(
                            children: <Widget>[
                              Text(
                                'Birth of Date',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          DateTimeFormField(
                            onDateSelected: (DateTime date) {
                              setState(() {
                                selectedDate = date;
                                // print(selectedDate.toString());
                                setState(() {
                                  String dMonth = "";
                                  if (selectedDate.month < 10) {
                                    dMonth = "0${selectedDate.month}";
                                  } else {
                                    dMonth = selectedDate.month.toString();
                                  }
                                  boD =
                                      "${selectedDate.day}/$dMonth/${selectedDate.year}";
                                  print(boD);
                                });
                              });
                            },
                            lastDate: DateTime(2022),
                            decoration: textInputDecoration.copyWith(
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),

                          SizedBox(height: size.height * 0.02),

                          // Citizen ID card number
                          Row(
                            children: <Widget>[
                              Text(
                                'Citizen ID Card Number',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: '0123456789xxx',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(left: 20)),
                            cursorColor: colorDarkPurple,
                            validator: (val) =>
                                (val.isEmpty || val.length != 13)
                                    ? 'Enter a proper ID card'
                                    : null,
                            onChanged: (val) {
                              setState(() => idCardNum= val);
                            },
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Email
                          Row(
                            children: <Widget>[
                              Text(
                                'Email',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(left: 20)),
                            cursorColor: colorDarkPurple,
                            validator: (val) =>
                                (val.isEmpty || !val.contains('@'))
                                    ? 'Enter a proper email'
                                    : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Password
                          Row(
                            children: <Widget>[
                              Text(
                                'Password',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: colorDarkPurple,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(left: 20)),
                            obscureText: true,
                            cursorColor: colorDarkPurple,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter a password';
                              }
                              if (val.length < 6) {
                                return 'Password length must be greater than 6 characters';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Confirm-password
                          Row(
                            children: <Widget>[
                              Text(
                                'Confirm-password',
                                style: registerLabel,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: colorDarkPurple,
                                  fontStyle: FontStyle.italic),
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                            obscureText: true,
                            cursorColor: colorDarkPurple,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter a password';
                              }
                              if (val != password) {
                                return 'Password and Confirm password must be the same!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
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
                                  spreadRadius: 1.5,
                                  blurRadius: 9,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: FlatButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  if (selectedradio == 1) gender = 'Male';
                                  if (selectedradio == 2) gender = 'Female';
                                  // if (selectedradio == 3) gender = 'Other';
                                  print(gender);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email,
                                          password,
                                          name,
                                          surName,
                                          gender,
                                          phoneNumber,
                                          boD);
                                  if (result == null) {
                                    setState(() {
                                      error = 'please supply a valid email';
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5),
                              ),
                              color: colorDarkPurple,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 80.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
  }
}
