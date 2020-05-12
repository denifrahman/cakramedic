import 'package:flutter/material.dart';

class topAppBar extends StatelessWidget {
  topAppBar({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
    title: Text("Jadwal Ngajar"),
    backgroundColor: Colors.purple,
    );
  }
}
