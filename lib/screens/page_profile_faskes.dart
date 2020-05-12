import 'dart:convert';

import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';

class page_profile_faskes extends StatefulWidget {
  page_profile_faskes({Key key}) : super(key: key);

  @override
  _page_profile_faskesState createState() {
    return _page_profile_faskesState();
  }
}

class _page_profile_faskesState extends State<page_profile_faskes> {

  String info_nama = '';
  String info_alamat = '';
  String info_phone = '';
  String info_fax = '';
  String info_kodepos = '';
  String info_email = '';
  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getInfo(){
    Api.getInfo().then((response){
      var result = json.decode(response.body);
      setState(() {
        info_nama = result['data']['info_nama'];
        info_alamat = result['data']['info_alamat'];
        info_phone = result['data']['info_phone'];
        info_fax = result['data']['info_fax'];
        info_kodepos = result['data']['info_kodepos'];
        info_email = result['data']['info_email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: Colors.grey[200],
      appBar: AppBar(
//        background // color: Colors.white,
//        iconTheme: IconThemeData(
//          color: Colors.black, //change your color here
//        ),
        elevation: 0,
        title: Row(
          children: <Widget>[
            Text('Profile ',style: TextStyle(color: Colors.cyan),),
            Text('Faskes',style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 35),
              padding: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 35),
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyan[700]),
//                           // color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 50,left: 13),
                          child: ListTile(
                            title: Text(info_nama),
                            dense: true,
                            subtitle: Text(info_alamat),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 25,
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage('assets/logo.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 25,
                      child: Icon(Icons.assignment_ind,color: Colors.cyan,)
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan[700]),
                   // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text('KODE POS : $info_kodepos')),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan[700]),
                   // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text('PHONE: $info_phone')),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan[700]),
                   // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text('FAX: $info_fax')),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan[700]),
                   // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text('EMAIL: $info_email')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text('-- Powerd By Cakramedic --',style: TextStyle(color: Colors.grey),),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buttonBack() {
//    Navigator.of(context).pop(true);
  }
}
