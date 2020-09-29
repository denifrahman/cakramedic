import 'dart:convert';
import 'package:cakramedic/providers/booking.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class widget_detail_booking_non_pasien extends StatefulWidget {
  widget_detail_booking_non_pasien({Key key, this.tanggal_booking, this.no_ktp}) : super(key: key);
  final String tanggal_booking, no_ktp;

  @override
  _widget_detail_booking_non_pasienState createState() {
    return _widget_detail_booking_non_pasienState();
  }
}

class _widget_detail_booking_non_pasienState extends State<widget_detail_booking_non_pasien> {
  @override
  void initState() {
    getDetailBookingNonPasien();
    super.initState();
  }
  bool _loading = false;
  Map<String, dynamic> dataDetailBooking;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in', null);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Booking'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : dataDetailBooking == null ? Center(child: Text('Data tidak tersedia'),) : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        children: <Widget>[
                          Text(
                            dataDetailBooking['ambil_nama'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            dataDetailBooking['ambil_no_ktp'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          Container(
                            height: 18,
                          ),
                          Text(
                            'Nomor Antrian',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18,color: Colors.grey, fontWeight: FontWeight.normal),
                          ),
                          Container(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                    color: Colors.cyan[700], //new Color.fromRGBO(255, 0, 0, 0.0),
                                    borderRadius: new BorderRadius.all(Radius.circular(40.0))),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      dataDetailBooking['jenis_antrian_label'] + (dataDetailBooking['jenis_antrian_awalnomor'] == '1' ? dataDetailBooking['antrian_loket_nomor'] : dataDetailBooking['jenis_antrian_awalnomor'] == '101' ? (100 + int.parse(dataDetailBooking['antrian_loket_nomor'])).toString() :dataDetailBooking['jenis_antrian_awalnomor'] == '300' ? (300+ int.parse(dataDetailBooking['antrian_loket_nomor'])).toString(): '0') ,
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "WorkSansSemiBold", fontWeight: FontWeight.bold),
                                    ))),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(DateFormat("EEEE, dd MMM yyyy", 'in').format(DateTime.parse(dataDetailBooking['ambil_antrian_tanggal'].toString())), textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                                Container(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Text(
                                'Silahkan datang ke charlie pada tanggal',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              )),
                          Text(
                            DateFormat("EEEE, dd MMM yyyy", 'in').format(DateTime.parse(dataDetailBooking['ambil_antrian_tanggal'].toString())),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontFamily: 'WorkSansSemiBold', color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void getDetailBookingNonPasien() {
    setState(() {
      _loading = true;
    });
    Api.getBookingNonPasienByNoKtp(widget.tanggal_booking, widget.no_ktp).then((response) {
      var result = json.decode(response.body);
      if (result['meta']['success']) {
        setState(() {
          dataDetailBooking = result['data'];
          _loading = false;
        });
      }else{
        setState(() {
          dataDetailBooking = result['data'];
          _loading = false;
        });
      }
    });
  }
}
