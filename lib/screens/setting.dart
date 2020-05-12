import 'dart:convert';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/screens/finger_print.dart';
import 'package:cakramedic/utils/ThemeChanger.dart';
import 'package:cakramedic/utils/Themes.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:cakramedic/utils/Themes.dart';

class setting extends StatefulWidget {
  setting({Key key}) : super(key: key);

  @override
  _settingState createState() {
    return _settingState();
  }
}

class _settingState extends State<setting> {
  bool isSwitched = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  int _groupTheme = 0;
  String label = "";

  @override
  void initState() {
    _getSettingFinger();
    super.initState();
  }

  _getSettingFinger() async {
    String settingLocal =
    await LocalStorage.sharedInstance.readValue('setting');
    var setting = json.decode(settingLocal);
    String themeData = await LocalStorage.sharedInstance.readValue('theme');
    var themes = json.decode(themeData);
    print(themes['theme']);
    if (themes['theme'] == '0') {
      setState(() {
        label = 'Default System';
      });
    } else if (themes['theme'] == '2') {
      setState(() {
        label = 'Dark Theme';
      });
    } else if (themes['theme'] == '1') {
      setState(() {
        label = 'Light Theme';
      });
    }
    setState(() {
      _groupTheme = int.parse(themes['theme']);
    });
    if (setting['finger_print'] == 'false') {
      setState(() {
        isSwitched = false;
      });
    } else {
      setState(() {
        isSwitched = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
//    try {
    availableBiometrics = await auth.getAvailableBiometrics();
    print(availableBiometrics);
//    } on PlatformException catch (e) {
//      print(e);
//    }
//    if (!mounted) return;
//    setState(() {
//      _availableBiometrics = availableBiometrics;
//    });
    print(availableBiometrics);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
//            Align(
//                alignment: Alignment.centerLeft,
//                child: Container(
//                    padding: EdgeInsets.only(
//                        left: 15, right: 15, bottom: 0, top: 20),
//                    child: Text(
//                      'Security',
//                      style: TextStyle(
//                          fontWeight: FontWeight.w600,
//                          fontSize: 16,
//                          color: Colors.grey),
//                    ))),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.only(left: 35, right: 15),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text('Finger Print'),
//                        Switch(
//                          value: isSwitched,
//                          onChanged: (value) {
//                            _changeFinger(value);
//                          },
//                          activeTrackColor: Colors.cyan[200],
//                          activeColor: Colors.cyan[700],
//                        ),
//                      ],
//                    ),
//                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 0, top: 20),
                          child: Text(
                            'Themes',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey),
                          ))),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 15),
                    child: InkWell(
                      onTap: () => _modalChangeThemes(),
                      child: ListTile(
                        title: Text(
                          'Change',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        leading: Container(
                            padding: EdgeInsets.only(top: 7),
                            child: Icon(
                              Icons.brightness_6,
                              size: 30,
                            )),
                        subtitle: Text(label),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _modalChangeThemes() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
//        ThemeCanger _themeCanger = Provider.of<ThemeCanger>(context);
        return AlertDialog(
          title: Text('Change Themes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) =>
                      ListTile(
                        title: const Text('Dark Theme'),
                        onTap: () {
                          _handleRadioValueChange1(2);
                          notifier.toggleTheme(2);
                        },
                        leading: Radio(
                          value: 2,
                          groupValue: _groupTheme,
                          onChanged: (value) {
                            _handleRadioValueChange1(value);
                            notifier.toggleTheme(2);
                          },
                        ),
                      ),
                ),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) =>
                      ListTile(
                        title: const Text('Light Theme'),
                        onTap: () {
                          _handleRadioValueChange1(1);
                          notifier.toggleTheme(1);
                        },
                        leading: Radio(
                          value: 1,
                          groupValue: _groupTheme,
                          onChanged: (value) {
                            _handleRadioValueChange1(value);
                            notifier.toggleTheme(1);
                          },
                        ),
                      ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _groupTheme = value;

      switch (_groupTheme) {
        case 1:
          setState(() {
            _groupTheme = 1;
            label = 'Dark Theme';
          });
          Navigator.of(context, rootNavigator: true).pop();
          String theme = '{"theme":"1"}';
          LocalStorage.sharedInstance.writeValue(key: 'theme', value: theme);
          break;
        case 2:
          setState(() {
            _groupTheme = 2;
            label = 'Light Theme';
          });
          String theme = '{"theme":"2"}';
          LocalStorage.sharedInstance.writeValue(key: 'theme', value: theme);
          Navigator.of(context, rootNavigator: true).pop();
          break;
      }
    });
  }

  void _changeFinger(value) {
//    _getAvailableBiometrics();
    print(value);
    if (value == false) {
      setState(() {
        isSwitched = false;
      });
    } else {
      setState(() {
        isSwitched = true;
      });
    }
    String setting_finger = '{"finger_print":"$value"}';
    LocalStorage.sharedInstance
        .writeValue(key: 'setting', value: setting_finger);
  }

  _openFinger() {
    Navigator.push(
      context,
      ScaleRoute(page: finger_print()),
    );
  }
}
