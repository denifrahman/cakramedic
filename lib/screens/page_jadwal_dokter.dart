import 'dart:convert';

import 'package:cakramedic/models/dokter.dart';
import 'package:cakramedic/models/master_jadwal_dokter.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:table_calendar/table_calendar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class page_jadwal_dokter extends StatefulWidget {
  final String idUnit;
  final String namaUnit;
  page_jadwal_dokter({Key key, this.idUnit, this.namaUnit}) : super(key: key);

  @override
  _page_jadwal_dokterState createState() {
    return _page_jadwal_dokterState();
  }
}

class _page_jadwal_dokterState extends State<page_jadwal_dokter>
    with TickerProviderStateMixin {
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2020, 2, 24): ['Easter Monday'],
  };
  var listJadwal = new List<MasterJadwalDokter>();
  var listDokter = new List<Dokter>();
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  bool _saving = false;
  bool _show = false;
  @override
  void initState() {
    _getJadwalDokterByTgl(widget.idUnit);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print(Duration(days: 1));
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(widget.namaUnit),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(child: !_show ? _buildEventList():Center(child: Text('Data tidak tersedia'),)),
          ],
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)

  void _getJadwalDokterByTgl(id) async {
    print(id);
    setState(() {
      _saving = true;
    });
    Api.getDokter(id).then((response) {
      var resultDokter = json.decode(response.body)['data'];
      if(resultDokter != null) {
        setState(() {
          _saving = false;
          _show = false;
          Iterable list = json.decode(response.body)['data'];
          listDokter = list.map((model) => Dokter.fromMap(model)).toList();
        });
        for (var i = 0; i < resultDokter.length; i++) {
          Api.getJadwalDokterByUnitPegawai(
              resultDokter[i]['m_unit_id'], resultDokter[i]['m_pegawai_id'])
              .then((response) {
            var resultJadwal = json.decode(response.body)['data'];
            if (resultDokter[i]['m_pegawai_id'] ==
                resultJadwal[i]['m_pegawai_id'] &&
                resultDokter[i]['m_unit_id'] == resultJadwal[i]['m_unit_id']) {
              resultDokter[i]['jadwal'] = resultJadwal;
              setState(() {
                _saving = false;
                Iterable list = resultDokter;
                listJadwal = list
                    .map((model) => MasterJadwalDokter.fromMap(model))
                    .toList();
              });
            }
//          }
          });
        }
      }else{
        setState(() {
          _saving = false;
          _show = true;
//          Iterable list = json.decode(response.body)['data'];
//          listDokter = list.map((model) => Dokter.fromMap(model)).toList();
        });
      };
//      setState(() {
//        _saving = false;
//
//      });
    });
  }

  Widget _buildEventList() {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ListView.builder(
          itemCount: listDokter.length,
          itemBuilder: (context, i) {
            if(i == null){
              i = i;
            }
            print('show $_show');
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(listDokter[i].pegawaiNama, style: TextStyle(fontSize: 15),),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 180,
                        child: new GridView.count(
                          primary: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          children:
                              List.generate(listJadwal[i].jadwal.length, (j) {
                                print(i);
                            var jam_awal =
                                listJadwal[i].jadwal[j].jadwaldokterJamAwal;
                            var jam_akhir =
                                listJadwal[i].jadwal[j].jadwaldokterJamAkhir;
                            var hari = listJadwal[i].jadwal[j].jadwaldokterHari;
//
                            return listJadwal[i].jadwal != null ?Column(
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  width: 200,
//                                    height:200,
                                  child: Center(child: Text(
                                      "$hari \n $jam_awal-$jam_akhir",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white))),
                                ),
                              ],
                            ): Container(child: Center(child: Text('Data Tidak tersedia'),));
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
