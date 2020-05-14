import 'package:cakramedic/screens/page_login.dart';
import 'package:cakramedic/screens/page_login_management.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class page_portal extends StatefulWidget {
  page_portal({Key key}) : super(key: key);

  @override
  _page_portalState createState() {
    return _page_portalState();
  }
}

class _page_portalState extends State<page_portal> {
  @override
  void initState() {
    super.initState();
  }
  DateTime currentBackPressTime;
  @override
  void dispose() {
    super.dispose();
  }


  Widget _buildHeader() {
    return Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(height: 30,),
            Image(
                width: 120,
//                      height: 191.0,
                fit: BoxFit.fill,
                image: new AssetImage('assets/logo.png')),
            Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Cakra Link',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }

  Widget _buildCardMenu(title) {
    return
      MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => page_portal(),
          // When navigating to the "/second" rou
        },
        home: Container(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style:
                    TextStyle(fontSize: 18, fontFamily: "WorkSansMedium"),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0)),
                    child: Icon(Icons.person, size: 70,),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        elevation: 0,
//        title: Align(
//          alignment: Alignment.center,
//          child: Text('Welcome'),
//        ),
//      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: _buildHeader()),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: ()=>_openAksesPasien(),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Cakralink Patient',
                                style:
                                TextStyle(fontSize: 18, fontFamily: "WorkSansMedium"),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0),
                                    bottom: Radius.circular(10.0)),
                                child: Image(
                                    width: 50,
                                    fit: BoxFit.fill,
                                    image: new AssetImage('assets/pasien.png')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
//                  Container(
//                    child: Card(
//                      elevation: 5,
//                      margin: EdgeInsets.all(5),
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      child: InkWell(
//                        onTap: () {
//                          showDialog(
//                              context: context,
//                              builder: (_) =>
//                                  ThemeConsumer(child: ThemeDialog()));
//                        },
//                        child: Container(
//                          padding: EdgeInsets.all(10),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Text(
//                                'Cakralink Doktor',
//                                style:
//                                TextStyle(
//                                    fontSize: 18, fontFamily: "WorkSansMedium"),
//                              ),
//                              ClipRRect(
//                                borderRadius: BorderRadius.vertical(
//                                    top: Radius.circular(10.0),
//                                    bottom: Radius.circular(10.0)),
//                                child: Image(
//                                    width: 50,
//                                    fit: BoxFit.fill,
//                                    image: new AssetImage('assets/dokter.png')),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                  Container(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () => _openAksesManagement(),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Cakralink Management',
                                style:
                                TextStyle(
                                    fontSize: 18, fontFamily: "WorkSansMedium"),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0),
                                    bottom: Radius.circular(10.0)),
                                child: Image(
                                    width: 50,
                                    fit: BoxFit.fill,
                                    image: new AssetImage('assets/logo.png')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex:0,
              child:
                  Text(
                    "-- Powered by Cakramedic --",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                  ),
            ),
          ],
        ),
      ),
    );
  }
  _openAksesPasien(){
    Navigator.push(
      context,
      ScaleRoute(page: LoginPage()),
    );
//    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//        LoginPage()), (Route<dynamic> route) => false);
  }

  _openPagePendaftaran() {
//    Navigator.push(
//      context,
//      ScaleRoute(page: page_pendaftaran_pasien()),
//    );
  }

  _openAksesManagement() {
    Navigator.push(
      context,
      ScaleRoute(page: LoginPageManagement()),
    );
//
  }
}
