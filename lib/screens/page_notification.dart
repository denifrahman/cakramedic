import 'package:flutter/material.dart';
import '../style/theme.dart' as Theme;

class screen_notification extends StatefulWidget {
  screen_notification({Key key}) : super(key: key);

  @override
  _screen_notificationState createState() {
    return _screen_notificationState();
  }
}

class _screen_notificationState extends State<screen_notification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifikasi',style: TextStyle(fontSize: 18),),
          backgroundColor: Theme.Colors.themesBasic,
        ),
      );
  }
}