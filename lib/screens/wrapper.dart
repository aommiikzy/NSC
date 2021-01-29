import 'package:flutter/material.dart';
import 'package:mu_dent/models/user.dart';
import 'package:mu_dent/screens/patient/home/home.dart';
import 'package:provider/provider.dart';
import 'package:mu_dent/screens/authenticate/sign_in.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);
    if (user == null) {
      print('user is null');
      return SignIn();
    } else {
      // print('user');
      return Home();
    }
  }
}
