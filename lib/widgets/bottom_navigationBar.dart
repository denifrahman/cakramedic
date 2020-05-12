  import 'package:flutter/material.dart';
  import 'package:cakramedic/utils/responsive_screen.dart';
  import '../style/theme.dart' as Theme;

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomNavBar({Key key, this.changeCurrentTab}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;
  Screen size;


  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        iconSize: size.getWidthPx(24),
        currentIndex: tab,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.cyan[700],
        backgroundColor: Colors.grey[100],
//      elevation: 4,
        selectedFontSize: 15.0,
        showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            if (index != 4) {
              tab = index;
              widget.changeCurrentTab(index);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.grey.shade50,
            icon: Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontFamily: 'WorkSansMedium')),
          ),BottomNavigationBarItem(
            backgroundColor: Colors.grey.shade50,
            icon: Icon(Icons.library_books),
            title: Text('Aktivitas', style: TextStyle(fontFamily: 'WorkSansMedium')),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey.shade50,
            icon: Icon(Icons.inbox),
            title: Text('Inbox', style: TextStyle(fontFamily: 'WorkSansMedium')),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey.shade50,
            icon: Icon(Icons.person),
            title: Text('Account', style: TextStyle(fontFamily: 'WorkSansMedium')),
          ),
        ],
      ),
    );
  }
  Future<bool> _onWillPop() {
    setState(() {
      tab = 0;
    });
  }
}
