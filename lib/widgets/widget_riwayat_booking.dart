import 'dart:convert';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/models/m_riwayat_booking.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:cakramedic/screens/page_detail_booking.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:cakramedic/widgets/widget_detail_booking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class widget_riwayat_booking extends StatefulWidget {
  widget_riwayat_booking({Key key}) : super(key: key);

  @override
  _widget_riwayat_bookingState createState() {
    return _widget_riwayat_bookingState();
  }
}

class _widget_riwayat_bookingState extends State<widget_riwayat_booking> {
  bool statusBooking= false;
  var dataHistory = new List<MRiwayatBooking>();
  bool _saving = false;
  @override
  int dataSetting = 1;
  void initState() {
    super.initState();
    _getSettingJam();
  }

  _getBookingHistory()async{
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var data = json.decode(dataSession);
    Api.getBookingByPasienAndStatus(data['data']['m_pasien_id'], 'BATAL','LAYANI').then((response){
      var result = json.decode(response.body);
      print(result);
      if (result['meta']['success'] == true) {
        setState(() {
          _saving = false;
          Iterable list = json.decode(response.body)['data'];
          dataHistory =
              list.map((model) => MRiwayatBooking.fromMap(model)).toList();
        });
        print(dataHistory.length);
      } else {
        setState(() {
          _saving = false;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  _openDetailBooking(){
    Navigator.push(
      context,
      ScaleRoute(page: page_detail_booking()),
    );
  }
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    _getSettingJam();
    _getBookingHistory();

    return null;
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    initializeDateFormatting('in', null);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Riwayat Booking',style: TextStyle(),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 25,
            child: RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: ListView.builder(
                  itemCount: dataHistory.length, itemBuilder: (context, index) {
                    DateTime tanggal_booking = DateTime.parse(dataHistory[index].tglBooking);
                return InkWell(
                  onTap: ()=> _getPedaftaranByPendaftaranId(dataHistory[index].pendaftaranId),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Text(
                              dataHistory[index].kodebooking,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        subtitle: Text(DateFormat("EEE, dd MMMM",'in')
                            .format(tanggal_booking)),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.bookmark,
                          size: 30,
                        ),
                        trailing: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            dataHistory[index].statusbooking == 'LAYANI'
                                ? Icon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: Colors.green,
                              size: 18,
                            )
                                : Icon(
                              FontAwesomeIcons.exclamationCircle,
                              color: Colors.amber,
                              size: 18,
                            ),
                            dataHistory[index].statusbooking == 'LAYANI'
                                ? Text(
                              dataHistory[index].statusbooking,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 12),
                            )
                                : Text(dataHistory[index].statusbooking,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
  _getPedaftaranByPendaftaranId(pendaftaranId){
    setState(() {
      _saving = true;
    });
    Api.getBookingByPendaftaranId(pendaftaranId).then((response){
      var result = json.decode(response.body);
      if(result['meta']['success'] == true){
//        print(result);
        setState(() {
          _saving = false;
        });
        Navigator.push(
          context,
          ScaleRoute(page: widget_detail_booking(dataDetailBooking:response.body, settingWaktuChekin:dataSetting)),
        ).then((value) {
          _getBookingHistory();
        });
      }
    });
  }
  _getSettingJam(){
    Api.getSettingInitWaktuChekin().then((response){
      var result = json.decode(response.body);
      setState(() {
        dataSetting = int.parse(result['data']['init_nilai_integer']);
      });
      _getBookingHistory();
    });
  }
}