import 'package:flutter/material.dart';
import 'package:cakramedic/LocalBindings.dart';

class profile_screen extends StatefulWidget {
  profile_screen({Key key}) : super(key: key);
  static const routeName = '/profile-screen';
  @override
  _profile_screenState createState() {
    return _profile_screenState();
  }
}

class _profile_screenState extends State<profile_screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void logOut(){
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.of(context).pushReplacementNamed('/main');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Jadwal Ngajar"),
        ),
        body: Container(
          child: Column(children: <Widget>[
            RaisedButton(child: Text('Logut'), onPressed: ()=>logOut(),)
          ],),
        ),
    );
  }
}