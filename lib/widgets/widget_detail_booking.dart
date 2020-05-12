import 'dart:convert';
import 'package:cakramedic/providers/booking.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class widget_detail_booking extends StatelessWidget {
  final String dataDetailBooking;
  final int settingWaktuChekin;
  widget_detail_booking({Key key, this.dataDetailBooking, this.settingWaktuChekin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in', null);
    var dataResult = json.decode(dataDetailBooking);
    var tglBooking = DateFormat("EEEE, dd MMM yyyy", 'in').format(DateTime.parse(dataResult['data']['tanggal_masuk'].toString()));
    int hourseSetting = settingWaktuChekin;
    var kedatanganJam =int.parse(dataResult['data']['jadwalpraktek_jam_awal'].substring(0,2)) - hourseSetting;
    var menit = dataResult['data']['jadwalpraktek_jam_awal'].substring(2,5);

   print('$kedatanganJam$menit');
    // TODO: implement build
    return Scaffold(
//      background // color: Colors.white,
      appBar: AppBar(
//        background // color: Colors.white,
//        iconTheme: IconThemeData(
//          color: Colors.black, //change your color here
//        ),
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Booking'),
            Text(tglBooking, style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Selamat Pendaftaran Berhasil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 18,
                    ),
                    Text(
                      dataResult['data']['unit_nama'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    Container(height: 5,),
                    Text(
                      dataResult['data']['pegawai_nama'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    Container(
                      height: 18,
                    ),
                    Text(
                      'Nomor Antrian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 50,
                          height:50,
                          decoration: new BoxDecoration(
                              color: Colors
                                  .cyan[700], //new Color.fromRGBO(255, 0, 0, 0.0),
                              borderRadius:
                              new BorderRadius.all(Radius.circular(40.0))),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                dataResult['data']['no_antrian_dokter'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "WorkSansSemiBold",
                                    fontWeight: FontWeight.bold),
                              ))),
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
//                          color: Colors.grey[180],
                          borderRadius: new BorderRadius.all(
                              Radius.circular(10.0))
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'KODE BOOKING',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
//                                      color: Colors.black2,
                              child: QrImage(
                                backgroundColor: Colors.white,
                                data: dataResult['data']['kodebooking'],
                                version: QrVersions.auto,
                                size: 300.0,
                              ),
                            ),
                          ),
                          Text(
                            dataResult['data']['kodebooking'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(tglBooking,textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold ,color: Colors.grey)),
                          Container(width: 10,),
                          Text(dataResult['data']['jadwalpraktek_jam_awal'].substring(0,5),textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,color: Colors.grey)),

                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top:10),
                        child: Text('Anda Harus Checkin / Konfirmasi Sebelum', textAlign: TextAlign.center, style: TextStyle(fontSize: 15),)),
                  Text( '$tglBooking Jam $kedatanganJam$menit' , textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'WorkSansSemiBold',color: Colors.red),),
                  ],
                ),
              ),
              dataResult['data']['statusbooking'] != 'BOOKING'? Container(): dataResult['data']['statusbooking'] != 'LAYANI'? Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                    new BorderRadius.all(Radius.circular(40.0))
                ),
                child: MaterialButton(
                  onPressed: ()=>_batalNow(context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 52.0),
                    child: Text(
                      "Batal Booking",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "WorkSansMedium"),
                    ),
                  ),),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
  void _batalBooking(context){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: new Text(
                "Apakah anda yakin ingin membatalkan?",
                style: TextStyle(fontSize: 12),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Tidak"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Iya", style: TextStyle()),
                  onPressed: () {
                    _batalNow(context);
                  },
                ),
              ],
            ));
      },
    );
  }
  _batalNow(context){
//    Navigator.of(context, rootNavigator: true).pop();
    var dataResult = json.decode(dataDetailBooking);
    Map data = {
      'statusbooking': "BATAL",
      'pendaftaran_id': dataResult['data']['pendaftaran_id']
    };
    var body = json.encode(data);
    Api.ubah(body).then((response){
      var result = json.decode(response.body);
      print(result);
      if(result['meta']['success'] == true){
        Navigator.of(context).pop('String');
      }else{

      }
    });
  }
}
