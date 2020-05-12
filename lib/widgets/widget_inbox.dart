import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class widget_inbox extends StatelessWidget {
  widget_inbox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
//        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
//          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: Text('Inbox',),
      ),
    );
  }
}
