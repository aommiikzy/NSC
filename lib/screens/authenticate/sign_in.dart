import 'package:flutter/material.dart';
import 'package:mu_dent/screens/patient/home/home.dart';
import 'package:mu_dent/services/auth.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:mu_dent/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.grey[100],
            body: SafeArea(
                child: Center(
              child: SingleChildScrollView(
                child: Stack(children: <Widget>[
                  Container(
                    width: size.width * 0.8,
                    // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: size.height * 0.02),
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/pic.jpg'),
                            radius: 100.0,
                          ),
                          SizedBox(height: size.height * 0.045),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(Icons.person,
                                    color: colorDarkPurple),
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                color: colorDarkPurple,
                                fontStyle: FontStyle.italic,
                                fontSize: 18.0,
                              ),
                              // contentPadding: EdgeInsets.all(15)
                            ),
                            cursorColor: colorDarkPurple,
                            onChanged: ((val) => email = val),
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 13.0),
                                child:
                                    Icon(Icons.lock, color: colorDarkPurple),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: colorDarkPurple,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0,
                                  fontFamily: 'OpenSans'),
                              // contentPadding: EdgeInsets.all(15),

                              // contentPadding: EdgeInsets.only(left: 20)
                            ),
                            obscureText: true,
                            cursorColor: colorDarkPurple,
                            onChanged: ((val) => password = val),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Forgot password?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'OpenSans'),
                              ),
                              // SizedBox(width: 10.0),
                            ],
                          ),
                          SizedBox(height: size.height * 0.019),
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
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: FlatButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'could not sign in with those credentials';
                                      loading = false;
                                    });
                                  } else {
                                    // Navigator.pushReplacement(context, '/home');
                                    // Navigator.pushReplacementNamed(
                                    //     context, '/home');
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/home', (route) => false);
                                  }
                                }
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                    fontFamily: 'OpenSans'),
                              ),
                              color: colorGreen1,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 45.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(error,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 14,
                                color: Colors.red,
                              )),
                          // SizedBox(height: size.height * 0.02),
                          Text(
                            'or',
                            style: TextStyle(fontSize: 16.0),
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
                                  color: Colors.grey.withOpacity(0.37),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Log in as Guest',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                    fontFamily: 'OpenSans'),
                              ),
                              color: colorLightPurple,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 45.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            "Don't have an account yet?",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'OpenSans'),
                          ),
                          SizedBox(height: size.height * 0.007),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.37),
                                  spreadRadius: 0.5,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              color: colorDarkPurple,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 80.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
