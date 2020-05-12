import 'dart:convert';
import 'package:cakramedic/models/nomor_panggilan.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:cakramedic/models/antrian.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cakramedic/LocalBindings.dart';

class widget_antrian extends StatefulWidget {
  widget_antrian({Key key}) : super(key: key);

  @override
  _widget_antrianState createState() {
    return _widget_antrianState();
  }
}

class _widget_antrianState extends State<widget_antrian> {
  @override
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool _saving = false;
  var dataBooking = new List<Antrian>();
  var dataAntrian = new List<NomorPanggilan>();
  int dataSetting = 1;
  String totalAntrian = "";
  String antrianPanggil = "";
  Timer timer;

  void initState() {
    _initializeTimer();
    _getAntrianByPasien();
//    _getTotalAntrian();
    super.initState();
  }

  void _initializeTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (__) {
      _getAntrianByPasien();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _getAntrianByPasien() async {
    setState(() {
      _saving = true;
    });
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var data = json.decode(dataSession);
    Api.getAntrianByPasien(data['data']['m_pasien_id']).then((response) {
      var resultBooking = json.decode(response.body);
      print(resultBooking == null);
      if (resultBooking != 'null') {
//        print('data ada');
        for (var i = 0; i < resultBooking.length; i++) {
          Api.getAntrianPanggil('y', resultBooking[i]['t_jadwalpraktek_id'])
              .then((response) {
            var resultAntrian = json.decode(response.body)['data'];
//            print('$resultAntrian antrian');
            bool resultAntrianBool = resultAntrian == null;
            print(resultAntrianBool);
            if (!resultAntrianBool) {
              print('panggil no null');
              for (var j = 0; j < resultAntrian.length; j++) {
                if (resultAntrian[j]['jadwal'] ==
                    resultBooking[i]['t_jadwalpraktek_id']) {
                  resultBooking[i].addAll(resultAntrian[j]);
                  setState(() {
                    _saving = false;
                    Iterable list = resultBooking;
                    dataBooking =
                        list.map((model) => Antrian.fromMap(model)).toList();
                  });
                } else {
                  print('tet');
                  setState(() {
                    _saving = false;
                    Iterable list = resultBooking;
                    dataBooking =
                        list.map((model) => Antrian.fromMap(model)).toList();
                  });
                }
              }
            } else {
              print('panggil null');
              setState(() {
                _saving = false;
                Iterable list = resultBooking;
                dataBooking =
                    list.map((model) => Antrian.fromMap(model)).toList();
              });
            }
          });
        }
      } else {
        print('data kosong');
        setState(() {
          _saving = false;
//          Iterable list = resultBooking;
          dataBooking = [];
        });
      }
    });
  }

//  _getTotalAntrian() async {
//    setState(() {
//      _saving = true;
//    });
//    Api.getTotalAntrian('t').then((response) {
//      var result = json.decode(response.body);
//      print(result);
//      setState(() {
//        totalAntrian = result['data']['total_antrian'];
//      });
//    });
//  }

  _getAntrinPanggil(status_panggil, jadwal_praktek_id) async {
    setState(() {
      _saving = true;
    });
    Api.getAntrianPanggil(status_panggil, jadwal_praktek_id).then((response) {
      var result = json.decode(response.body);
      print(result['data']);
      var panggil = '0';
      if (result['data'] == null) {
        panggil = '0';
      } else {
        panggil = result['data']['panggil_antrian'];
      }
      setState(() {
        _saving = false;
        Iterable list = json.decode(response.body)['data'];
        dataAntrian =
            list.map((model) => NomorPanggilan.fromMap(model)).toList();
      });
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    _getAntrianByPasien();
//    _initializeTimer();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          flex: 25,
          child: RefreshIndicator(
            onRefresh: refreshList,
            key: refreshKey,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataBooking.length,
                itemBuilder: (context, index) {
                  DateTime tanggal_booking = DateTime.parse(
                      dataBooking[index].tanggalMasuk.toString());
                  return InkWell(
//                onTap: ()=>_getPedaftaranByPendaftaranId(dataBooking[index].pendaftaranId),
                      child: Stack(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                              title: Text(
                                dataBooking[index].pegawaiNama,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(dataBooking[index].unitNama,
                                  style: TextStyle(color: Colors.white)),
                              trailing: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                      color: Colors
                                          .white, //new Color.fromRGBO(255, 0, 0, 0.0),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(100.0))),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
//                                      Container(height: 10,),
                                          Text(
                                            'Antrian',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            dataBooking[index].noAntrianDokter,
                                            style: TextStyle(
                                                color: Colors.cyan[700],
                                                fontSize: 22,
                                                fontFamily: "WorkSansSemiBold",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80.0),
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Antrian Sedang DILAYANI',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          height: 30,
                                        ),
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: new BoxDecoration(
                                              color: Colors.green[
                                                  300], //new Color.fromRGBO(255, 0, 0, 0.0),
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(100.0))),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                dataBooking[index]
                                                            .panggilAntrian !=
                                                        null
                                                    ? dataBooking[index]
                                                        .panggilAntrian
                                                    : '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        "WorkSansSemiBold",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
//                                Container(height: 20,),
//                                Align(
//                                  alignment: Alignment.center,
//                                  child: ListTile(
//                                    title: Text('Total Antrian', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),),
//                                    trailing: Container(
//                                        width: 80,
//                                        height: 80,
//                                        decoration: new BoxDecoration(
//                                            color: Colors
//                                                .red[300], //new Color.fromRGBO(255, 0, 0, 0.0),
//                                            borderRadius:
//                                            new BorderRadius.all(Radius.circular(100.0))),
//                                        child: Align(
//                                            alignment: Alignment.center,
//                                            child: Text(
//                                              totalAntrian,
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontSize: 20,
//                                                  fontFamily: "WorkSansSemiBold",
//                                                  fontWeight: FontWeight.bold),
//                                            ))),
//                                  ),
//                                ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ));
                }),
          ),
        )
      ],
    );
  }
}
