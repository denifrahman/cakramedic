import 'dart:convert';
import 'dart:math';
import 'package:cakramedic/widgets/WidgetPendapatanTunaiUnitPenjamin.dart';
import 'package:cakramedic/widgets/WidgetTotalPasien.dart';
import 'package:cakramedic/widgets/widgetPendapatan.dart';
import 'package:provider/provider.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/utils/DataProvider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:cakramedic/models/Farmasi.dart';
import 'package:cakramedic/models/InstalasiKamarJenazah.dart';
import 'package:cakramedic/models/Penunjang.dart';
import 'package:cakramedic/models/RawatDaruta.dart';
import 'package:cakramedic/models/RawatInap.dart';
import 'package:cakramedic/models/RawatJalan.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cakramedic/models/m_penjamin.dart';
import 'package:cakramedic/models/m_poli_klinik.dart';
import 'package:intl/intl.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:cakramedic/widgets/widget_pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:money2/money2.dart';

class page_dashboard_management extends StatefulWidget {
  page_dashboard_management({Key key}) : super(key: key);

  @override
  _page_dashboard_managementState createState() {
    return _page_dashboard_managementState();
  }
}

class _page_dashboard_managementState extends State<page_dashboard_management>
    with SingleTickerProviderStateMixin {
  bool _saving = false;
  final ind = Currency.create('IN', 0, symbol: 'Rp', pattern: 'S ###,###');
  TabController _controller;

  @override
  void initState() {
    super.initState();
    checkIntroducing();
//    _getPoliKlinik();
//    _getPenjamin();
//    _getPendapatan();
//    _getAllPasien();
    _getKunjunganPerTanggalAndInstalasi();
    _controller = new TabController(length: 2, vsync: this);
  }

  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  var dataPenjamin = new List<MPenjamin>();

  String unitId;
  String penjaminId;
  String piutangUnitId;
  String piutangPenjaminId;
  String piutangStatusUnitId;
  String piutangStatusPenjaminId;

  String totalPasien, PasienLakiLaki, PasienPerempuan, HariIni;
  Money PendapatanTotal;
  Money PendapatanUnitTotal;
  Money PendapatanPenjaminTotal;
  Money PiutangUnitTotal;
  Money PiutangPenjaminTotal;

  DateTime sampaiDate = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month + 1, 0);
  DateTime dariDate = DateTime(DateTime.now().year, DateTime.now().month);

  DateTime datePendapatan = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatan = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month + 1, 0);
  DateTime datePendapatanUnit = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month);
  DateTime toDatePendapatanUnit = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month + 1, 0);
  DateTime datePendapatanPenjamin = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month);
  DateTime toDatePendapatanPenjamin = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month + 1, 0);

  DateTime datePiutangUnit = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month);
  DateTime toDatePiutangUnit = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  DateTime datePiutangPenjamin = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month);
  DateTime toDatePiutangPenjamin = DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month + 1, 0);

  var dataRawatDarurat = new List<RawatDarurat>();
  var dataRawatInap = new List<RawatInap>();
  var dataRawatJalan = new List<RawatJalan>();
  var dataFarmasi = new List<Farmasi>();
  var dataPenunjang = new List<Penunjang>();
  var dataInstalasiKamarJenazah = new List<InstalasiKamarJenazah>();

  @override
  void dispose() {
    super.dispose();
  }

  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  void checkIntroducing() async {
    String isIntro = await LocalStorage.sharedInstance.readValue('intro');
    if (isIntro == null) {
      initTargets();
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    }
  }

  void showTutorial() {
    TutorialCoachMark(context, targets: targets,
        colorShadow: Colors.red,
        paddingFocus: 10,
        opacityShadow: 0.8,
        finish: () {
//          print("finish");
          String setting_finger = '{"intro":"true"}';
          LocalStorage.sharedInstance.writeValue(
              key: 'intro', value: setting_finger);
        },
        clickTarget: (target) {
          print(target.identify);
        },
        clickSkip: () {
//          print("skip");
          String setting_finger = '{"intro":"true"}';
          LocalStorage.sharedInstance.writeValue(
              key: 'intro', value: setting_finger);
        })
      ..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
  }

  void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Filter Pendapatan",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Pilih icon tanggal berwarna kuning",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));

    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Pilih rentang tanggal",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(width: 180,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/tutorial/tips1.gif'))),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

//  _getPendapatanUnit() {
//    Api.getPendapatanTunaiUnit(
//            DateFormat('yyyy-MM-dd').format(datePendapatanUnit).toString(), DateFormat('yyyy-MM-dd').format(toDatePendapatanUnit).toString(), unitId)
//        .then((value) {
//      var result = json.decode(value.body);
//      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
//      setState(() {
//        PendapatanUnitTotal = total;
//      });
//    });
//  }
//
//  _getPendapatanPenjamin() {
//    Api.getPendapatanTunaiPenjamin(DateFormat('yyyy-MM-dd').format(datePendapatanPenjamin).toString(),
//            DateFormat('yyyy-MM-dd').format(toDatePendapatanPenjamin).toString(), penjaminId)
//        .then((value) {
//      var result = json.decode(value.body);
//      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
//      setState(() {
//        PendapatanPenjaminTotal = total;
//      });
//    });
//  }

  _getPiutangUnit() {
    Api.getPiutangUnit(
        DateFormat('yyyy-MM-dd').format(datePiutangUnit).toString(),
        DateFormat('yyyy-MM-dd').format(toDatePiutangUnit).toString(),
        piutangUnitId, piutangStatusUnitId.toString())
        .then((value) {
      var result = json.decode(value.body);
      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
      setState(() {
        PiutangUnitTotal = total;
      });
    });
  }

  _getPiutangPenjamin() {
    Api.getPiutangPenjamin(
        DateFormat('yyyy-MM-dd').format(datePiutangPenjamin).toString(),
        DateFormat('yyyy-MM-dd').format(toDatePiutangPenjamin).toString(),
        piutangPenjaminId, piutangStatusPenjaminId)
        .then((value) {
      var result = json.decode(value.body);
      var total = Money.fromInt(int.parse(result['data'].toString()), ind);
      setState(() {
        PiutangPenjaminTotal = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider themeNotifier = Provider.of<DataProvider>(context);
//    print(PendapatanTotal.toString().isNotEmpty);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  WidgetPendapatan(width: width,),
                  WidgetTotalPasien(width: width, themeNotifier: themeNotifier),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              'Piutang',
                                              style: TextStyle(fontSize: 15,
                                                  color: Colors.cyan[800]),
                                            ),
                                          ),
                                          Icon(
                                            Icons.sync,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      height: 80,
                                      child: new TabBar(
                                        isScrollable: true,
                                        labelColor: Colors.cyan,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorPadding: EdgeInsets.all(10),
                                        indicatorColor: Colors.cyan,
                                        indicator: new BubbleTabIndicator(
                                          indicatorHeight: 30.0,
                                          indicatorColor: Colors.grey[200],
                                          tabBarIndicatorSize: TabBarIndicatorSize
                                              .tab,
                                        ),
                                        controller: _controller,
                                        tabs: [
                                          new Tab(
                                            text: 'Unit',
                                          ),
                                          new Tab(
                                            text: 'Penjamin',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 180,
                                      child: new TabBarView(
                                        controller: _controller,
                                        children: <Widget>[
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 5),
                                                      child: DateTime(DateTime
                                                          .now()
                                                          .year, DateTime
                                                          .now()
                                                          .month) !=
                                                          DateFormat(
                                                              'yyyy-MM-dd')
                                                              .format(
                                                              datePendapatanPenjamin) &&
                                                          DateFormat(
                                                              'yyyy-MM-dd')
                                                              .format(
                                                              toDatePendapatanPenjamin) !=
                                                              DateFormat(
                                                                  'yyyy-MM-dd')
                                                                  .format(
                                                                  DateTime(
                                                                      DateTime
                                                                          .now()
                                                                          .year,
                                                                      DateTime
                                                                          .now()
                                                                          .month +
                                                                          1, 0))
                                                          ? Row(
                                                        children: <Widget>[
                                                          Text(
                                                            DateFormat(
                                                                'dd/MMM/yyyy')
                                                                .format(
                                                                datePiutangUnit)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey[500]),
                                                          ),
                                                          Container(
                                                            width: 5,
                                                          ),
                                                          Text("s/d",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .cyan[800])),
                                                          Container(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                'dd/MMM/yyyy')
                                                                .format(
                                                                toDatePiutangUnit)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey[500]),
                                                          ),
                                                        ],
                                                      )
                                                          : Text(
                                                        'Bulan Ini',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          _selectMonthPiutangUnit(
                                                              context),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, right: 5),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Icon(Icons
                                                                .date_range,
                                                                size: 30,
                                                                color: Colors
                                                                    .amber),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                themeNotifier.listPoliKlinik_
                                                    .isNotEmpty
                                                    ? DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration
                                                      .collapsed(hintText: ''),
                                                  hint: new Text(
                                                    "Pilih Unit",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  value: unitId,
                                                  onChanged: (String newValue) {
                                                    _onchangePiutangUnit(
                                                        newValue);
                                                  },
                                                  items: themeNotifier
                                                      .listPoliKlinik_.map((
                                                      MPoliKlinik item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: item.unitId
                                                          .toString(),
                                                      child: new Text(
                                                        item.unitNama
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                                    : Container(),
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration
                                                      .collapsed(hintText: ''),
                                                  hint: new Text(
                                                    "Pilih Status",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  value: piutangStatusUnitId,
                                                  items: [
                                                    "TERBUKA",
                                                    "KONFIRMASI",
                                                    "KIRIM",
                                                    "LUNAS",
                                                    "TAK TERTAGIH"
                                                  ]
                                                      .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(label,
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        value: label,
                                                      ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      piutangStatusUnitId = value;
                                                    });
                                                    _getPiutangUnit();
                                                  },
                                                ),
                                                Text(
                                                  PiutangUnitTotal.toString() ==
                                                      'null'
                                                      ? 'Rp 0'
                                                      : PiutangUnitTotal
                                                      .toString(),
                                                  style: TextStyle(fontSize: 22,
                                                      fontWeight: FontWeight
                                                          .w900),
                                                )
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 5),
                                                      child: DateTime(DateTime
                                                          .now()
                                                          .year, DateTime
                                                          .now()
                                                          .month) !=
                                                          DateFormat(
                                                              'yyyy-MM-dd')
                                                              .format(
                                                              datePendapatanPenjamin) &&
                                                          DateFormat(
                                                              'yyyy-MM-dd')
                                                              .format(
                                                              toDatePendapatanPenjamin) !=
                                                              DateFormat(
                                                                  'yyyy-MM-dd')
                                                                  .format(
                                                                  DateTime(
                                                                      DateTime
                                                                          .now()
                                                                          .year,
                                                                      DateTime
                                                                          .now()
                                                                          .month +
                                                                          1, 0))
                                                          ? Row(
                                                        children: <Widget>[
                                                          Text(
                                                            DateFormat(
                                                                'dd/MMM/yyyy')
                                                                .format(
                                                                datePendapatanPenjamin)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey[500]),
                                                          ),
                                                          Container(
                                                            width: 5,
                                                          ),
                                                          Text("s/d",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .cyan[800])),
                                                          Container(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                'dd/MMM/yyyy')
                                                                .format(
                                                                toDatePendapatanPenjamin)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey[500]),
                                                          ),
                                                        ],
                                                      )
                                                          : Text(
                                                        'Bulan Ini',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          _selectMonthPiutangPenjamin(
                                                              context),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, right: 5),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Icon(Icons
                                                                .date_range,
                                                                size: 30,
                                                                color: Colors
                                                                    .amber),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                dataPenjamin.isNotEmpty
                                                    ? DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration
                                                      .collapsed(hintText: ''),
                                                  hint: new Text(
                                                    "Pilih Pejamin",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  value: penjaminId,
                                                  onChanged: (String newValue) {
                                                    _onchangePiutangPenjamin(
                                                        newValue);
                                                  },
                                                  items: dataPenjamin.map((
                                                      MPenjamin item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: item.penjaminId
                                                          .toString(),
                                                      child: new Text(
                                                        item.penjaminNama
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                                    : Container(),
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration
                                                      .collapsed(hintText: ''),
                                                  hint: new Text(
                                                    "Pilih Status",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  value: piutangStatusPenjaminId,
                                                  items: [
                                                    "TERBUKA",
                                                    "KONFIRMASI",
                                                    "KIRIM",
                                                    "LUNAS",
                                                    "TAK TERTAGIH"
                                                  ]
                                                      .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(label,
                                                            style: TextStyle(
                                                                fontSize: 13)),
                                                        value: label,
                                                      ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      piutangStatusPenjaminId =
                                                          value;
                                                    });
                                                    _getPiutangPenjamin();
                                                  },
                                                ),
                                                Text(
                                                  PiutangPenjaminTotal
                                                      .toString() == 'null'
                                                      ? 'Rp 0'
                                                      : PiutangPenjaminTotal
                                                      .toString(),
                                                  style: TextStyle(fontSize: 22,
                                                      fontWeight: FontWeight
                                                          .w900),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: PieChartSample2(),
                  ),
                  Container(
                      child: Card(
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Grafik Kunjungan Per Instalasi',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(
                                                  Icons.date_range, size: 30,
                                                  color: Colors.amber),
                                              onPressed: () async {
                                                final List<
                                                    DateTime> picked = await DateRagePicker
                                                    .showDatePicker(
                                                  context: context,
                                                  initialFirstDate: dariDate,
                                                  initialLastDate: sampaiDate,
                                                  firstDate: DateTime(DateTime
                                                      .now()
                                                      .year - 50, 5),
                                                  lastDate: DateTime(DateTime
                                                      .now()
                                                      .year + 50, 9),
                                                );
                                                if (picked != null &&
                                                    picked.length == 2) {
                                                  if (picked[0] != picked[1]) {
                                                    setState(() {
                                                      dariDate = picked[0];
                                                      sampaiDate = picked[1];
                                                    });
                                                  } else {
                                                    Flushbar(
                                                      title: "Gagal",
                                                      message: "Grafik tidak bisa menampilkan jika tanggal sama, silahkan pilih minimal rentang 1 hari",
                                                      duration: Duration(seconds: 5),
                                                      backgroundColor: Colors.red,
                                                      flushbarPosition: FlushbarPosition.TOP,
                                                      icon: Icon(
                                                        Icons.error,
                                                        color: Colors.white,
                                                      ),
                                                    )..show(context);
                                                  }
                                                }
                                              }),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                DateFormat('dd/MMM/yyyy')
                                                    .format(dariDate)
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Container(
                                                width: 20,
                                              ),
                                              Text(
                                                DateFormat('dd/MMM/yyyy')
                                                    .format(sampaiDate)
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              new Container(
//                            decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                                child: new TabBar(
                                  isScrollable: true,
                                  labelColor: Colors.cyan,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorPadding: EdgeInsets.all(10),
                                  indicatorColor: Colors.cyan,
                                  indicator: new BubbleTabIndicator(
                                    indicatorHeight: 30.0,
                                    indicatorColor: Colors.grey[200],
                                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  controller: _controller,
                                  tabs: [
                                    new Tab(
                                      text: 'Harian',
                                    ),
                                    new Tab(
                                      text: 'Bulanan',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              new Container(
                                padding: EdgeInsets.all(10),
                                height: 300.0,
                                child: new TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    ahad(context),
                                    bulanan(context),
                                  ],
                                ),
                              ),
                            ],
                          ))),
                ],
              ),
            )),
      ),
    );
  }

  Future<Null> _selectMonthPiutangUnit(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: datePiutangUnit,
      initialLastDate: toDatePiutangUnit,
      firstDate: DateTime(DateTime.now().year - 50, 5),
      lastDate: DateTime(DateTime.now().year + 50, 9),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        datePiutangUnit = picked[0];
        toDatePiutangUnit = picked[1];
      });
      _getPiutangUnit();
    }
  }

  Future<Null> _selectMonthPiutangPenjamin(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: datePiutangPenjamin,
      initialLastDate: toDatePiutangPenjamin,
      firstDate: DateTime(DateTime.now().year - 50, 5),
      lastDate: DateTime(DateTime.now().year + 50, 9),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        datePiutangPenjamin = picked[0];
        toDatePiutangPenjamin = picked[1];
      });
      _getPiutangPenjamin();
    }
  }

  Future<Null> _dari(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context,
        initialDate: dariDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dariDate)
      setState(() {
        dariDate = picked;
      });
    _getKunjunganPerTanggalAndInstalasi();
  }

  Future<Null> _sampai(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context,
        initialDate: sampaiDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sampaiDate)
      setState(() {
        sampaiDate = picked;
      });

    _getKunjunganPerTanggalAndInstalasi();
  }

  void _getKunjunganPerTanggalAndInstalasi() {
    Api.getKunjunganPerTangganAndInstalasi(
        DateFormat('yyyy-MM-dd').format(dariDate).toString(),
        DateFormat('yyyy-MM-dd').format(sampaiDate).toString())
        .then((value) {
      var result = json.decode(value.body);
      setState(() {
        //        Data farmasi
        Iterable farmasi = result['data']['FARMASI'];
        dataFarmasi = farmasi.map((model) => Farmasi.fromMap(model)).toList();
        //        Data Instalasi Kamar Jenazah
        Iterable instalasiKamarJenazah = result['data']['INSTALASI_KAMAR_JENAZAH'];
        dataInstalasiKamarJenazah = instalasiKamarJenazah.map((model) =>
            InstalasiKamarJenazah.fromMap(model)).toList();
        //        Data penunjang
        Iterable penunjang = result['data']['PENUNJANG'];
        dataPenunjang =
            penunjang.map((model) => Penunjang.fromMap(model)).toList();
        //        Data rawatDarurat
        Iterable rawatDarurat = result['data']['RAWAT_DARURAT'];
        dataRawatDarurat =
            rawatDarurat.map((model) => RawatDarurat.fromMap(model)).toList();
        //        Data rawatInap
        Iterable rawatInap = result['data']['RAWAT_INAP'];
        dataRawatInap =
            rawatInap.map((model) => RawatInap.fromMap(model)).toList();
        //  Data penunjang
        Iterable rawatjalan = result['data']['RAWAT_JALAN'];
        dataRawatJalan =
            rawatjalan.map((model) => RawatJalan.fromMap(model)).toList();
      });
    });
  }

  Widget ahad(BuildContext context) {
    final fromDate = dariDate;
    final toDate = sampaiDate;
    final date1 = DateTime(2019, 05, 01);
    final date2 = DateTime(2019, 05, 30);
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          onIndicatorVisible: (val) {
//            print("Indicator Visible :$val");
          },
          onDateTimeSelected: (datetime) {
//            print("selected datetime: $datetime");
          },
          selectedDate: toDate,
          //this is optional
          footerDateTimeBuilder: (DateTime value, BezierChartScale scaleType) {
            final newFormat = intl.DateFormat('d \n MMM');
            return newFormat.format(value);
          },
          series: [
            dataFarmasi.isNotEmpty
                ? BezierLine(
                    label: "Farmasi",
              lineColor: dataFarmasi.isNotEmpty ? convertToColor(
                  dataFarmasi[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataFarmasi.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Farmasi",
                lineColor: dataFarmasi.isNotEmpty ? convertToColor(
                    dataFarmasi[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataInstalasiKamarJenazah.isNotEmpty
                ? BezierLine(
                    label: "KM Jenazah",
              lineColor: dataInstalasiKamarJenazah.isNotEmpty ? convertToColor(
                  dataInstalasiKamarJenazah[0].color) : Colors.grey,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataInstalasiKamarJenazah.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "KM Jenazah",
                lineColor: dataInstalasiKamarJenazah.isNotEmpty
                    ? convertToColor(dataInstalasiKamarJenazah[0].color)
                    : Colors.grey,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatInap.isNotEmpty
                ? BezierLine(
                    label: "Rawat Inap",
              lineColor: dataRawatInap.isNotEmpty ? convertToColor(
                  dataRawatInap[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatInap.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Inap",
                lineColor: dataRawatInap.isNotEmpty ? convertToColor(
                    dataRawatInap[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatJalan.isNotEmpty
                ? BezierLine(
                    label: "Rawat Jalan",
              lineColor: dataRawatJalan.isNotEmpty ? convertToColor(
                  dataRawatJalan[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatJalan.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Jalan",
                lineColor: dataRawatJalan.isNotEmpty ? convertToColor(
                    dataRawatJalan[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatDarurat.isNotEmpty
                ? BezierLine(
                    label: "Rawat Darurat",
              lineColor: dataRawatDarurat.isNotEmpty ? convertToColor(
                  dataRawatDarurat[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatDarurat.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Darurat",
                lineColor: dataRawatDarurat.isNotEmpty ? convertToColor(
                    dataRawatDarurat[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataPenunjang.isNotEmpty
                ? BezierLine(
                    label: "Penunjang",
              lineColor: dataPenunjang.isNotEmpty ? convertToColor(
                  dataPenunjang[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataPenunjang.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Penunjang",
                lineColor: dataPenunjang.isNotEmpty ? convertToColor(
                    dataPenunjang[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
          ],
          config: BezierChartConfig(
            displayDataPointWhenNoValue: true,
            verticalIndicatorStrokeWidth: 3.0,
            pinchZoom: false,
            physics: ClampingScrollPhysics(),
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            displayYAxis: true,
            stepsYAxis: 25,
            xLinesColor: Colors.white,
            xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            yAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            verticalIndicatorFixedPosition: true,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget bulanan(BuildContext context) {
    final fromDate = dariDate;
    final toDate = sampaiDate;
    final date1 = DateTime(2019, 05, 01);
    final date2 = DateTime(2019, 05, 30);
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.MONTHLY,
          toDate: toDate,
          onIndicatorVisible: (val) {
//            print("Indicator Visible :$val");
          },
          onDateTimeSelected: (datetime) {
//            print("selected datetime: $datetime");
          },
          selectedDate: toDate,
          //this is optional
          footerDateTimeBuilder: (DateTime value, BezierChartScale scaleType) {
            final newFormat = intl.DateFormat('MMM');
            return newFormat.format(value);
          },
          series: [
            dataFarmasi.isNotEmpty
                ? BezierLine(
                    label: "Farmasi",
              lineColor: dataFarmasi.isNotEmpty ? convertToColor(
                  dataFarmasi[0].color) : Colors.orange,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataFarmasi.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Farmasi",
                lineColor: dataFarmasi.isNotEmpty ? convertToColor(
                    dataFarmasi[0].color) : Colors.orange,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataInstalasiKamarJenazah.isNotEmpty
                ? BezierLine(
                    label: "KM Jenazah",
              lineColor: dataInstalasiKamarJenazah.isNotEmpty ? convertToColor(
                  dataInstalasiKamarJenazah[0].color) : Colors.grey,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataInstalasiKamarJenazah.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "KM Jenazah",
                lineColor: dataInstalasiKamarJenazah.isNotEmpty
                    ? convertToColor(dataInstalasiKamarJenazah[0].color)
                    : Colors.grey,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatInap.isNotEmpty
                ? BezierLine(
                    label: "Rawat Inap",
              lineColor: dataRawatInap.isNotEmpty ? convertToColor(
                  dataRawatInap[0].color) : Colors.blue,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatInap.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Inap",
                lineColor: dataRawatInap.isNotEmpty ? convertToColor(
                    dataRawatInap[0].color) : Colors.blue,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatJalan.isNotEmpty
                ? BezierLine(
                    label: "Rawat Jalan",
              lineColor: dataRawatJalan.isNotEmpty ? convertToColor(
                  dataRawatJalan[0].color) : Colors.brown,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatJalan.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Jalan",
                lineColor: dataRawatJalan.isNotEmpty ? convertToColor(
                    dataRawatJalan[0].color) : Colors.brown,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataRawatDarurat.isNotEmpty
                ? BezierLine(
                    label: "Rawat Darurat",
              lineColor: dataRawatDarurat.isNotEmpty ? convertToColor(
                  dataRawatDarurat[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataRawatDarurat.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Rawat Darurat",
                lineColor: dataRawatDarurat.isNotEmpty ? convertToColor(
                    dataRawatDarurat[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataPenunjang.isNotEmpty
                ? BezierLine(
                    label: "Penunjang",
              lineColor: dataPenunjang.isNotEmpty ? convertToColor(
                  dataPenunjang[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataPenunjang.map((e) {
                      return DataPoint<DateTime>(value: double.parse(e.count),
                          xAxis: DateTime.parse(e.tanggalMasuk));
                    }).toList(),
                  )
                : BezierLine(
                    label: "Penunjang",
                lineColor: dataRawatDarurat.isNotEmpty ? convertToColor(
                    dataPenunjang[0].color) : Colors.black,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
          ],
          config: BezierChartConfig(
            displayDataPointWhenNoValue: true,
            verticalIndicatorStrokeWidth: 3.0,
            pinchZoom: false,
            physics: ClampingScrollPhysics(),
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            displayYAxis: false,
            startYAxisFromNonZeroValue: true,
            stepsYAxis: 500,
            xLinesColor: Colors.white,
            xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            yAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            verticalIndicatorFixedPosition: true,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Color convertToColor(String color, {String opacity = 'ff'}) {
    return Color(int.parse('$opacity$color', radix: 16));
  }


  void _onchangePiutangUnit(String newValue) {
    setState(() {
      piutangUnitId = newValue;
    });
    _getPiutangUnit();
  }

  void _onchangePiutangPenjamin(String newValue) {
    setState(() {
      piutangPenjaminId = newValue;
    });
    _getPiutangPenjamin();
  }
}


