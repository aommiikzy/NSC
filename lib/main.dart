import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/screens/authenticate/register.dart';
import 'package:mu_dent/screens/authenticate/sign_in.dart';
import 'package:mu_dent/screens/patient/Appointment_Booking/booking1.dart';
import 'package:mu_dent/screens/patient/home/home.dart';
import 'package:mu_dent/screens/settings/setting.dart';
import 'package:mu_dent/screens/wrapper.dart';
import 'package:mu_dent/shared/loading.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:mu_dent/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefService.init(prefix: 'pref_');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
          child: MaterialApp(
        title: 'App',
        debugShowCheckedModeBanner: false,
        // home: Wrapper(),
        initialRoute: '/wrapper',
        routes: {
          '/': (context) => SignIn(),
          '/home': (context) => Home(),
          '/home/booking': (context) => PatientBooking(),
          '/settings': (context) => Setting(),
          '/signIn': (context) => SignIn(),
          '/register': (context) => Register(),
          '/wrapper': (context) => Wrapper(),
        },
      ),
    );
  }
}
