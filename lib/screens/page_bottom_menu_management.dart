import 'package:cakramedic/screens/page_dashboar_management.dart';
import 'package:cakramedic/screens/page_laporan_management.dart';
import 'package:cakramedic/screens/page_profile_management.dart';
import 'package:cakramedic/utils/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomMenuManagement extends StatefulWidget {
  static const routeName = '/mengajar-screen';

  @override
  _BottomMenuManagementState createState() => _BottomMenuManagementState();
}

class _BottomMenuManagementState extends State<BottomMenuManagement>
    with TickerProviderStateMixin {
  int i = 0;
  int _pState = 0;
  var pages = [
    new page_dashboard_management(),
    new page_profile_management()
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() {
    if (i == 0) {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  /*Navigator.of(context).pop(true)*/
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      setState(() {
        i = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: pages[i],
          // drawer: new AppNavigationDrawer(),
          bottomNavigationBar: new BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(
                  FontAwesomeIcons.chartPie,
                  size: 18,
                ),
                title: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text('Dashboard',
                      style: TextStyle(fontFamily: 'WorkSans', fontSize: 11)),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(
                  FontAwesomeIcons.userCircle,
                  size: 18,
                ),
                title: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text('Account',
                      style: TextStyle(fontFamily: 'WorkSans', fontSize: 11)),
                ),
              ),
            ],
            currentIndex: i,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey[500],
            selectedItemColor: Colors.white,
            elevation: 1,
            backgroundColor:
                !notifier.darkTheme ? Colors.black : Colors.cyan[900],
            onTap: (index) {
              print(index);
              setState(() {
                _pState = i;
                i = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
