import 'dart:convert';
import 'package:cakramedic/models/m_penjamin.dart';
import 'package:intl/intl.dart';
import 'package:cakramedic/models/m_poli_klinik.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money2/money2.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'OpenSans-Semibold',
  primaryColor: Colors.cyan[900],
);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
//  scaffoldBackgroundColor: Colors.black,
    fontFamily: 'OpenSans-Semibold');

class DataProvider extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;
  final ind = Currency.create('IN', 0, symbol: 'Rp', pattern: 'S ###,###');

  bool get darkTheme => _darkTheme;

  DataProvider() {
    getAllPasien();
    getPoliKlinik();
    getPenjamin();
    getPendapatan();
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme(param) {
    if (param == 1) {
      _darkTheme = true;
    } else if (param == 2) {
      _darkTheme = false;
    }
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }

  String totalPasien, pasienLakiLaki, pasienPerempuan, hariIni;

  String get totalPasien_ => totalPasien;

  String get pasienLakiLaki_ => pasienLakiLaki;

  String get pasienPerempuan_ => pasienPerempuan;

  String get hariIni_ => hariIni;

  getAllPasien() {
    Api.getAllPasien().then((value) {
      var result = json.decode(value.body);
      totalPasien = result['data']['total'];
      pasienLakiLaki = result['data']['laki_laki'];
      pasienPerempuan = result['data']['perempuan'];
      hariIni = result['data']['today'];
      notifyListeners();
    });
  }

  var listPoliKlinik = new List<MPoliKlinik>();

  List<MPoliKlinik> get listPoliKlinik_ => listPoliKlinik;

  void getPoliKlinik() async {
    Api.getAllUnit().then((response) {
      var result = json.decode(response.body);
      if (result['status'] == 200) {
        Iterable list = json.decode(response.body)['data'];
        listPoliKlinik =
            list.map((model) => MPoliKlinik.fromMap(model)).toList();
      } else {}
    });
  }

  var dataPenjamin = new List<MPenjamin>();

  List<MPenjamin> get dataPenjamin_ => dataPenjamin;

  void getPenjamin() async {
    Api.getAllPenjamin().then((response) {
      Iterable list = json.decode(response.body)['data'];
      dataPenjamin = list.map((model) => MPenjamin.fromMap(model)).toList();
    });
  }

  DateTime datePendapatanUnit =
      DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatanUnit =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  DateTime datePendapatanPenjamin =
      DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatanPenjamin =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  String unitId, penjaminId;
  Money PendapatanUnitTotal;
  Money PendapatanPenjaminTotal;

  String get unitId_ => unitId;

  String get penjaminId_ => penjaminId;

  setUnitId(id) {
    unitId = id;
    notifyListeners();
  }

  setPenjaminId(id) {
    penjaminId = id;
    notifyListeners();
  }

  setDatePendapatanUnit(date) {
    datePendapatanUnit = date;
    getPendapatanUnit();
    notifyListeners();
  }

  setToDatePendapatanUnit(date) {
    toDatePendapatanUnit = date;
    getPendapatanUnit();
    notifyListeners();
  }

  setDatePendapatanPenjamin(date) {
    datePendapatanPenjamin = date;
    getPendapatanPenjamin();
    notifyListeners();
  }

  setToDatePendapatanPenjamin(date) {
    toDatePendapatanPenjamin = date;
    getPendapatanPenjamin();
    notifyListeners();
  }

  Money get pendapatanPenjaminTotal => PendapatanPenjaminTotal;

  Money get pendapatanUnitTotal => PendapatanUnitTotal;

  getPendapatanUnit() {
    Api.getPendapatanTunaiUnit(
            DateFormat('yyyy-MM-dd').format(datePendapatanUnit).toString(),
            DateFormat('yyyy-MM-dd').format(toDatePendapatanUnit).toString(),
            unitId)
        .then((value) {
      var result = json.decode(value.body);
      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
      PendapatanUnitTotal = total;
      notifyListeners();
    });
  }

  getPendapatanPenjamin() {
    Api.getPendapatanTunaiPenjamin(
            DateFormat('yyyy-MM-dd').format(datePendapatanPenjamin).toString(),
            DateFormat('yyyy-MM-dd')
                .format(toDatePendapatanPenjamin)
                .toString(),
            penjaminId)
        .then((value) {
      var result = json.decode(value.body);
      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
      PendapatanPenjaminTotal = total;
      notifyListeners();
    });
  }

  DateTime datePendapatan = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatan =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  Money PendapatanTotal;

  DateTime get datePendapatan_ => datePendapatan;

  DateTime get toDatePendapatan_ => toDatePendapatan;

  setDatePendapatan(date) {
    datePendapatan = date;
    getPendapatan();
    notifyListeners();
  }

  setToDatePendapatan(date) {
    toDatePendapatan = date;
    getPendapatan();
    notifyListeners();
  }

  Money get pendapatanTotal_ => PendapatanTotal;

  getPendapatan() {
    Api.getPendapatanTunai(
            DateFormat('yyyy-MM-dd').format(datePendapatan).toString(),
            DateFormat('yyyy-MM-dd').format(toDatePendapatan).toString())
        .then((value) {
      var result = json.decode(value.body);
      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
      PendapatanTotal = total;
      notifyListeners();
    });
  }
}
