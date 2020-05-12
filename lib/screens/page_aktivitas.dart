import 'package:cakramedic/widgets/widget_aktivitas.dart';
import 'package:cakramedic/widgets/widget_antrian.dart';
import 'package:cakramedic/widgets/widget_riwayat_booking.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';


class page_aktivitas extends StatefulWidget {
  page_aktivitas({Key key}) : super(key: key);

  @override
  _page_aktivitasState createState() {
    return _page_aktivitasState();
  }
}

class _page_aktivitasState extends State<page_aktivitas> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
//        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
//          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.cyan,
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: EdgeInsets.all(10),
                  indicatorColor: Colors.cyan,
                  indicator:  new BubbleTabIndicator(
                    indicatorHeight: 30.0,
                    indicatorColor: Colors.grey[200],
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    Tab(
                        child: Text('Aktivitas', style: TextStyle( fontWeight: FontWeight.w400),),
                    ),
                    Tab(
                      child: Text('Antrian Online Poliklinik', style: TextStyle( fontWeight: FontWeight.w400),),
                    )
                  ],
                ),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Aktivitas Saya', style: TextStyle(fontSize: 25, letterSpacing: 1,fontFamily: "WorkSansMedium"),),
              Icon(Icons.today,)
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  Expanded(child: widget_aktivitas())
                ],
              ),
              Container(
                  child: Center(
                    child: widget_antrian(),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}