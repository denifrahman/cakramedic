import 'dart:convert';
import 'dart:async';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:cakramedic/widgets/widget_detail_booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cakramedic/models/t_aktivitas.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class widget_aktivitas extends StatefulWidget {
  widget_aktivitas({Key key}) : super(key: key);

  @override
  _widget_aktivitasState createState() {
    return _widget_aktivitasState();
  }
}

class _widget_aktivitasState extends State<widget_aktivitas> {

  bool _saving = false;
  var dataBooking = new List<TAktivitas>();
  int dataSetting = 1;
  Timer timer;
  @override
  void initState() {
    super.initState();
    _getSettingJam();
    _getBookingHistory();
  }


  @override
  void dispose() {
    super.dispose();
  }
  _getBookingHistory()async{
    setState(() {
      _saving= true;
    });
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var data = json.decode(dataSession);
    Api.getBookingByPasienAndStatusBooking(data['data']['m_pasien_id'],'BOOKING').then((response){
      var result = json.decode(response.body);
//      print(result);
      if (result['meta']['success'] == true) {
        setState(() {
          _saving = false;
          Iterable list = json.decode(response.body)['data'];
          dataBooking =
              list.map((model) => TAktivitas.fromMap(model)).toList();
        });

      } else {
        setState(() {
          _saving = false;
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
    });
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
    var today = DateTime.now();
    initializeDateFormatting('in', null);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return ModalProgressHUD(
        inAsyncCall: _saving,
        child:Column(
      children: <Widget>[
        Expanded(
          flex: 25,
          child: RefreshIndicator(
            onRefresh: refreshList,
            key: refreshKey,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: dataBooking.length, itemBuilder: (context, index) {
              DateTime tanggal_booking = DateTime.parse( dataBooking[index].tanggalMasuk.toString());
              var kodeBooking = dataBooking[index].kodebooking.toString();
              return dataBooking.length != 0 ? InkWell(
                onTap: ()=>_getPedaftaranByPendaftaranId(dataBooking[index].pendaftaranId),
                child:
                Stack(
                  children: <Widget>[
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 90,
                          decoration: BoxDecoration(
                              color: Colors.cyan[500],
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.all(5),
                          child:
                          ListTile(
                            title: Text('Kode Booking : $kodeBooking', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold, fontSize: 17),),
                            subtitle: Text(DateFormat("EEE, dd MMMM yyyy",'in')
                                .format(tanggal_booking), style: TextStyle(color: Colors.grey[300])),
                            trailing:
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                dataBooking[index].statusbooking != 'BOOKING'
                                    ? Icon(
                                  FontAwesomeIcons.solidCheckCircle,
                                  color: Colors.white,
                                  size: 20,
                                )
                                    : Icon(
                                  FontAwesomeIcons.exclamationCircle,
                                  color: Colors.amber,
                                  size: 25,
                                ),
                                dataBooking[index].statusbooking != 'BOOKING'
                                    ? Text(
                                  dataBooking[index].statusbooking,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 12),
                                )
                                    : Text(dataBooking[index].statusbooking,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:80.0),
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        ),
                        child: Container(
                      height: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                            ),
                            padding: EdgeInsets.all(10),
                            child:
                            Align(
                              alignment: Alignment.center,
                              child: ListTile(
                                title: Text(dataBooking[index].unitNama, style: TextStyle(color: Colors.black),),
                                subtitle: Text(dataBooking[index].pegawaiNama, style: TextStyle(color: Colors.grey[700])),
                                trailing: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: new BoxDecoration(
                                        color: Colors
                                            .cyan[700], //new Color.fromRGBO(255, 0, 0, 0.0),
                                        borderRadius:
                                        new BorderRadius.all(Radius.circular(100.0))),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          dataBooking[index].noAntrianDokter,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "WorkSansSemiBold",
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ):Align(
                  alignment: Alignment.center,
                  child: Text('Data tidak ada',style: TextStyle(color: Colors.black),));
            }),
          ),
        )
      ],
    )
    );
  }
}