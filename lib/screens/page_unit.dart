import 'dart:convert';
import 'package:cakramedic/screens/page_jadwal_dokter.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cakramedic/models/m_poli_klinik.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';

class page_unit extends StatefulWidget {
  page_unit({Key key}) : super(key: key);

  @override
  _page_unitState createState() {
    return _page_unitState();
  }
}

class _page_unitState extends State<page_unit> {
  @override
  void initState() {
    _getPoliKlinik();
    super.initState();
  }

  var listUnit = new List<MPoliKlinik>();
  bool _saving = false;
  @override
  void dispose() {
    super.dispose();
  }

  void _getPoliKlinik() async {
    setState(() {
      _saving = true;
    });
    Api.getAllPoliKlinik().then((response) {
      var result = json.decode(response.body);
      print(result);
      if (result['status'] == 200) {
        setState(() {
          _saving = false;
          Iterable list = json.decode(response.body)['data'];
          listUnit = list.map((model) => MPoliKlinik.fromMap(model)).toList();
        });
      } else {
        setState(() {
          _saving = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Pilih Poli'),
        ),
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: Container(
                child: new GridView.count(
              primary: true,
              crossAxisCount: 3,
              childAspectRatio: 1.3,
              children: List.generate(listUnit.length, (j) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () => _openJadwalDokter(listUnit[j].unitId, listUnit[j].unitNama),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 2,right: 2),
                      child: Container(
                        height:100,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.only(right: 5, left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10))),
                        width: 200,
//                                    height:200,
                        child: Center(child: Text(
                          listUnit[j].unitNama, textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),)),
                      ),
                    ),
                  ),
                );
              }),
            ))));
  }

  _openJadwalDokter(id, nama) {
    Navigator.push(
      context,
      ScaleRoute(page: page_jadwal_dokter(
        idUnit: id,namaUnit: nama,
      )),
    );
  }
}
