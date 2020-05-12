
import 'package:cakramedic/models/dashboard.dart';
import 'package:cakramedic/screens/page_booking.dart';
import 'package:cakramedic/screens/page_dashboard.dart';
import 'package:cakramedic/screens/page_profile_new.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/theme.dart' as Theme;

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    dashboard_screen(),
    page_profile(),
    page_booking()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = dashboard_screen(); // Our first view in viewport
  _openBooking(){
    Navigator.push(
      context,
      ScaleRoute(
          page: page_booking()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Booking',
        child: Container(
//          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.library_books, color: Theme.Colors.themesBasic, size: 25,),
              Text('Book', style: TextStyle(color: Colors.cyan, fontSize: 11),)
            ],
          ),
        ),
        onPressed: ()=>_openBooking()

      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    padding: EdgeInsets.all(9),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            dashboard_screen(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.white : Colors.grey[300],
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.white : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
//                  MaterialButton(
////                    padding: EdgeInsets.all(8),
//                    minWidth: 40,
//                    onPressed: () {
//                      setState(() {
//                        currentScreen =
//                            riwayat_screen(); // if user taps on this dashboard tab will be active
//                        currentTab = 1;
//                      });
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Icon(
//                          Icons.history,
//                          color: currentTab == 1 ? Colors.white : Colors.grey[300],
//                        ),
//                        Text(
//                          'Riwayat',
//                          style: TextStyle(
//                            color: currentTab == 1 ? Colors.white : Colors.grey[300],
//                          ),
//                        ),
//                      ],
//                    ),
//                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            page_profile(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 2 ? Colors.white : Colors.grey[300],
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.white : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}