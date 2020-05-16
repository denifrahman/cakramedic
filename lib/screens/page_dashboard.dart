import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/screens/page_detail_booking.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:cakramedic/widgets/widget_home_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class dashboard_screen extends StatefulWidget {
  dashboard_screen({Key key}) : super(key: key);

  @override
  _dashboard_screenState createState() {
    return _dashboard_screenState();
  }
}

class _dashboard_screenState extends State<dashboard_screen> {
  @override
  void initState() {
    super.initState();
  }
  DateTime currentBackPressTime;
  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Keluar aplikasi?'),
        content: Text('Apakah anda ingin keluar aplikasi'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            /*Navigator.of(context).pop(true)*/
            child: Text('Ya'),
          ),
        ],
      ),
    ) ??
        false;
  }
  _openDetailBooking(){
    Navigator.push(
      context,
      ScaleRoute(page: page_detail_booking()),
    );
  }
 bool statusBooking= true;
  var dataSaldo = [
    {"id": "1", "kode_booking": "CHR001"},
    {"id": "1", "kode_booking": "CHR001"}
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          elevation: 0,
//          background // color: Colors.white,
          centerTitle: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                        width: 35,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/logo.png')),
                    Container(width: 15,),
                    Text('Charlie', style: TextStyle(color: Colors.cyan[500], fontSize: 25),),
                    Container(width: 5,),
                    Text('Hospital', style: TextStyle(color: Colors.grey[400], fontSize: 25),),
                  ],
                ),
//                Icon(
//                    Icons.menu,color: Colors.grey,
//                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  new Container(
                    padding:EdgeInsets.all(0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          child: Carousel(
                            autoplayDuration: Duration(seconds: 60),
                            autoplay: false,
                            radius: Radius.circular(30),
                            images: [
                              Image(
                                  width: 150,
//                      height: 191.0,
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/28533.jpg')),
                              Image(
                                  width: 150,
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/2547803.jpg'))
                            ],
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: Colors.lightGreenAccent,
                            indicatorBgPadding: 3.0,
                            dotBgColor: Colors.cyan.withOpacity(0.5),
                            borderRadius: false,
                          )),
                    ),
                  ),
                  Container(
//                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(left: 10, right:10,top: 0,bottom: 10),
                    decoration: BoxDecoration(
                     // color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(15.0),
                            bottomRight: const Radius.circular(15.0))
                    ),
                    child: widget_home_menu()
                  ),
//                  Container(
//                       // color: Colors.white,
//                      margin: EdgeInsets.only(top: 15),
//                      height: 270,
//                      width: MediaQuery.of(context).size.width,
//                      padding: EdgeInsets.only(left: 10, right:10,top: 10,bottom: 10),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text('Breaking News', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
//                          Container(height: 20,),
//                          Container(
//                            height: 200,
//                            child: ListView.builder(
//                                scrollDirection: Axis.horizontal,
//                                itemCount: 3,
//                                itemBuilder: (BuildContext context, int index) =>
//                                    Card(
//                                      child: Container(
//                                        padding: EdgeInsets.all(10),
//                                        width: 150,
//                                          child: Text('Contoh Berita')
//                                      ),
//                                    )
//                            ),
//                          ),
//                        ],
//                      )
//                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}