import 'package:cakramedic/widgets/WidgetPendapatanTunaiUnitPenjamin.dart';
import 'package:flutter/material.dart';

class page_detail_management extends StatefulWidget {
  page_detail_management({Key key}) : super(key: key);

  @override
  _page_detail_managementState createState() {
    return _page_detail_managementState();
  }
}

class _page_detail_managementState extends State<page_detail_management> {
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
        title: Text('Detail'),
      ),
      body: WidgetPendapatanTunaiUnitPenjamin(),
    );
  }
}