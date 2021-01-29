import 'package:flutter/material.dart';
import 'package:mu_dent/screens/settings/profile.dart';
import 'package:mu_dent/services/auth.dart';
import 'package:mu_dent/shared/constants.dart';
import 'package:preferences/preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  final AuthService _auth = AuthService();

  final List<String> menu = ['Profile', 'Notification', 'Language', 'About'];
  bool _toggled = true;
  String languageChoose;
  List<String> language = ['Thai', 'English'];
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorDarkPurple,
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    'Setting',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 20.0),
                  ),
                ],
              )),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text('Profile'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
            color: Colors.white,
            elevation: 3.0,
            child: SwitchListTile(
              activeColor: colorDarkPurple,
              title: Text('Notification'),
              value: _toggled,
              onChanged: (bool value) {
                setState(() {
                  return _toggled = value;
                });
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            color: Colors.white,
            elevation: 3.0,
            child: DropdownPreference(
              'Language',
              'language',
              defaultVal: 'English',
              values: language,
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            elevation: 3.0,
            onPressed: () async {
              // Navigator.popUntil(context, () => false);
              await _auth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/signIn', (route) => false);
              // print('click');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            splashColor: colorDarkPurple,
            child: Text(
              "Logout",
              style: TextStyle(
                color: Color(0xFFFE3E3E),
                fontSize: 17,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
