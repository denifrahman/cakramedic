import 'package:cakramedic/screens/page_aktivitas.dart';
import 'package:cakramedic/utils/ThemeChanger.dart';
import 'package:cakramedic/widgets/widget_inbox.dart';
import 'package:flutter/material.dart';
import 'package:cakramedic/screens/page_dashboard.dart';
import 'package:cakramedic/screens/page_profile_new.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style/theme.dart' as Theme;
import 'package:provider/provider.dart';

class BottomMenu extends StatefulWidget {
  static const routeName = '/mengajar-screen';
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with TickerProviderStateMixin {
//  int currentTab = 0;
//  PageController pageController;
//  List<Route<dynamic>> routeStack = List();
//  _changeCurrentTab(int tab) {
//    //Changing tabs from BottomNavigationBar
//    setState(() {
//      currentTab = tab;
//      pageController.jumpToPage(0);
//    });
//  }
//
//  @override
//  void initState() {
//    print(routeStack);
//    // TODO: implement initState
//    super.initState();
//    pageController = new PageController();
//  }
//
//  Future<bool> onWillPop() {
//    setState(() {
//      currentTab = 0;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primaryColor: Colors.cyan[700],
//          hintColor: Colors.white,
//          scaffoldBackgroundColor:Colors.white,
//      ),
//      home: Scaffold(
//          body: bodyView(currentTab),
//          bottomNavigationBar: BottomNavBar(changeCurrentTab: _changeCurrentTab)),
//    );
//
//  }
//
//  bodyView(currentTab) {
//    List<Widget> tabView = [];
//    //Current Tabs in Home Screen...
//    switch (currentTab) {
//      case 0:
//      //Dashboard Page
//        tabView = [dashboard_screen()];
//        break;
//      case 1:
//      //Search Page
//        tabView = [page_aktivitas()];
//        break;
//      case 2:
//      //Search Page
//        tabView = [widget_inbox()];
//        break;
//      case 3:
//      //Search Page
//        tabView = [profile_screen()];
//        break;
//    }
//    return PageView(controller: pageController, children: tabView);
//  }
  int i = 0;
  int _pState = 0;
  var pages = [new dashboard_screen(), new page_aktivitas(), new widget_inbox(), new page_profile()];

  @override
  void initState() {
    super.initState();
  }
  Future<bool> _onWillPop() {
    if(i == 0){
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
    }else{
    setState(() {
      i=0;
    });
    }


  }

  @override
  Widget build(BuildContext context) {
//    var brightness = MediaQuery.of(context).platformBrightness;
//    bool setting = true;
//    if(brightness == Brightness.dark){
//      setting = true;
//    }else{
//      setting = false;
//    }
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) =>
          WillPopScope(
            onWillPop: _onWillPop,
            child: new Scaffold(
              body: pages[i],
              // drawer: new AppNavigationDrawer(),
              bottomNavigationBar: new BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.grey.shade50,
                    icon: Icon(FontAwesomeIcons.home, size: 20,),
                    title: Text('Home',
                        style: TextStyle(fontFamily: 'WorkSans', fontSize: 12)),
                  ), BottomNavigationBarItem(
                    backgroundColor: Colors.grey.shade50,
                    icon: Icon(FontAwesomeIcons.bookmark, size: 20,),
                    title: Text('Aktivitas',
                        style: TextStyle(fontFamily: 'WorkSans', fontSize: 12)),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.grey.shade50,
                    icon: Icon(FontAwesomeIcons.inbox, size: 20,),
                    title: Text('Inbox',
                        style: TextStyle(fontFamily: 'WorkSans', fontSize: 12)),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.grey.shade50,
                    icon: Icon(FontAwesomeIcons.userCircle, size: 20,),
                    title: Text('Account',
                        style: TextStyle(fontFamily: 'WorkSans', fontSize: 12)),
                  ),
                ],
                currentIndex: i,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey[500],
                selectedItemColor: Colors.white,
                elevation: 1,
                backgroundColor: !notifier.darkTheme ? Colors.black : Colors
                    .cyan[900],
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
