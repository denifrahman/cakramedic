import 'dart:convert';

import 'package:cakramedic/providers/booking.dart';
import 'package:cakramedic/widgets/widget_detail_booking.dart';
import 'package:flutter/material.dart';

class page_detail_booking extends StatefulWidget {
  final String pendaftaranId;
  page_detail_booking({Key key, this.pendaftaranId}) : super(key: key);
  @override
  _page_detail_bookingState createState() {
    return _page_detail_bookingState();
  }
}

class _page_detail_bookingState extends State<page_detail_booking> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Booking'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
          child: widget_detail_booking()),
    );
  }
}