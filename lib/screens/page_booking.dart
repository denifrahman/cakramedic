import 'dart:convert';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/models/m_data_pasien.dart';
import 'package:cakramedic/models/m_jadwal_dokter.dart';
import 'package:cakramedic/models/m_penjamin.dart';
import 'package:cakramedic/models/m_poli_klinik.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'package:flushbar/flushbar.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class page_booking extends StatefulWidget {
  page_booking({Key key}) : super(key: key);

  @override
  _page_bookingState createState() {
    return _page_bookingState();
  }
}

class _page_bookingState extends State<page_booking> {
  var dataPenjamin = new List<MPenjamin>();
  var listPoliKlinik = new List<MPoliKlinik>();
  String penjaminPasien;
  int _counter = 0;
  File _imageFile;
  DateTime _selectedDateBook = DateTime.now();
  List initialSelectDate = [DateTime.now()];
  var listDokter = new List<MJadwalDokter>();
  var dataPasien = new List<MDataPasien>();

  String namaDokter = '';
  String namaPoli = '';
  String noAntrian_data = '';
  String kodeBooking_data = randomAlphaNumeric(5);
  String jamBukaDokter = '00:00:00';

  bool tutorial = false;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuPoliItems;
  List<DropdownMenuItem<String>> _dropDownMenuDokterItems;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;

  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController noRekamMedisController =
      new TextEditingController();
  final TextEditingController idNumberPenjaminController =
      new TextEditingController();

  final TextEditingController tahunLahirController =
      new TextEditingController();
  final TextEditingController tanggalLahirController =
      new TextEditingController();
  final TextEditingController bulanLahirController =
      new TextEditingController();

  DateFormat timeFormat;
  bool _saving = false;

  String titleButtonLanjut = "Lanjut";
  String titleButtonSimpan = "Simpan";
  String titleButtonKembali = "Kembali";

  int dataSetting = 0;
  String idUnit_data = '';
  String noRekamMedis = "";
  String namaPasien = "";
  String mInstalasiId = "";

  String alamatPasien =
      "alamat pasien default sistem cakra medic sdasdad sadsada sadsfsfdsfs";
  String pasienId = '';
  bool validErrNorm = false;
  bool showNumberAsuransi = false;
  bool showValidIdAsuransi = false;
  bool showValidBoxIdPenjamin = false;

  List<TargetFocus> targets = List();
  List<TargetFocus> targets2 = List();
  List<TargetFocus> targets3 = List();
  List<TargetFocus> targets4 = List();
  List<TargetFocus> targets5 = List();
  List<TargetFocus> targets6 = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();
  GlobalKey keyButton6 = GlobalKey();

  @override
  void initState() {
    checkIntroducing();
    _getUserdataLogin();
    _getPenjamin();
    _getPoliKlinik();
    _getSettingJam();
    super.initState();
    initializeDateFormatting('in').then((_) {
      timeFormat = DateFormat.Hm('in');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkIntroducing() async {
    String isIntro =
        await LocalStorage.sharedInstance.readValue('introBooking');
    if (isIntro == null) {
      setState(() {
        tutorial = true;
      });
      initTargets();
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    } else {
      setState(() {
        tutorial = false;
      });
    }
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
  }

  void showTutorial() {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.cyan[800],
      paddingFocus: 10,
      textSkip: ' ',
      opacityShadow: 0.8,
    )..show();
  }

  void showTutorial2() {
    TutorialCoachMark(
      context,
      targets: targets2,
      colorShadow: Colors.cyan[800],
      paddingFocus: 10,
      opacityShadow: 0.8,
    )..show();
  }

  void showTutorial3() {
    TutorialCoachMark(
      context,
      targets: targets3,
      colorShadow: Colors.cyan[800],
      paddingFocus: 10,
      textSkip: ' ',
      opacityShadow: 0.8,
    )..show();
  }

  void showTutorial4() {
    TutorialCoachMark(
      context,
      targets: targets4,
      colorShadow: Colors.cyan[800],
      paddingFocus: 10,
      opacityShadow: 0.8,
    )..show();
  }

  void showTutorial5() {
    TutorialCoachMark(
      context,
      targets: targets5,
      colorShadow: Colors.cyan[800],
      paddingFocus: 10,
      textSkip: ' ',
      opacityShadow: 0.8,
    )..show();
  }

  void showTutorial6() {
    TutorialCoachMark(context,
        targets: targets6,
        textSkip: ' ',
        colorShadow: Colors.cyan[800],
        paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
//          print("finish");
      String setting_finger = '{"introBooking":"true"}';
      LocalStorage.sharedInstance
          .writeValue(key: 'introBooking', value: setting_finger);
    })
      ..show();
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
                    "Penjamin / Asuransi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          image:
                              new AssetImage('assets/tutorial/asuransi.png'))),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Silahkan pilih penjamin yang anda miliki, jika tidak menggunakan silahkan pilih Umum",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets2.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Selanjutnya",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lanjutkan ke langkah berikutnya!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets3.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Selanjutnya",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "lanjutkan ke langkah berikutnya!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets4.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton4,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pilih Tanggal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Silahkan pilih tanggal kedatangan anda",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets5.add(TargetFocus(
      identify: "Target 5",
      keyTarget: keyButton5,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pilih Dokter",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Silahkan pilih Dokter",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets6.add(TargetFocus(
      identify: "Target 6",
      keyTarget: keyButton6,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Nomor Antrian",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Ini adalah estimasi nomor antrian anda bisa jadi setelah anda menekan tombol ya, antrian anda bisa menjadi lebih besar, karena sudah di booking pasien lain!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void _getJadwalDokterByTglAndPoli() async {
    setState(() {
      _saving = true;
    });
    Api.getJadwalDokterByTglAndPoli(
            DateFormat(
              "yyyy-MM-dd",
            ).format(_selectedDateBook),
            idUnit_data)
        .then((response) {
      var result = json.decode(response.body);
      if (result['data'] == null) {
        if (tutorial) {
          showTutorial5();
        }
        setState(() {
          listDokter = null;
          _saving = false;
        });
      } else {
        if (result['status'] == 200) {
          showTutorial5();
          setState(() {
            _saving = false;
            Iterable list = json.decode(response.body)['data'];
            listDokter =
                list.map((model) => MJadwalDokter.fromMap(model)).toList();
          });
        } else {
          setState(() {
            _saving = false;
          });
        }
      }
    });
  }

  _getSettingJam() {
    Api.getSettingInitWaktuChekin().then((response) {
      var result = json.decode(response.body);
      setState(() {
        dataSetting = int.parse(result['data']['init_nilai_integer']);
      });
    });
  }

  _getUserdataLogin() async {
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var result = json.decode(dataSession)['data'];
    setState(() {
      pasienId = result['m_pasien_id'];
    });
    _getDataPasienByNoRm(
        result['akunpasien_no_rm'], result['akunpasien_tgl_lahir']);
  }

  void _getPoliKlinik() async {
    setState(() {
      _saving = true;
    });
    Api.getAllPoliKlinik().then((response) {
      var result = json.decode(response.body);
      if (result['status'] == 200) {
        setState(() {
          _saving = false;
          Iterable list = json.decode(response.body)['data'];
          listPoliKlinik =
              list.map((model) => MPoliKlinik.fromMap(model)).toList();
        });
      } else {
        setState(() {
          _saving = false;
        });
      }
    });
  }

  void _getDataPasienByNoRm(noRm, tglLahir) async {
    setState(() {
      _saving = true;
    });
    if (noRm != '') {
      Api.getDataPasienByNoRm(noRm, tglLahir).then((response) {
        var result = json.decode(response.body);
        if (result['data'] != null) {
          var data = result['data'][0];
          setState(() {
            _saving = false;
            validErrNorm = false;
            noRekamMedis = data['pasien_norm'];
            namaPasien = data['pasien_nama'];
            alamatPasien = data['pasien_alamat'];
          });
        } else {
          setState(() {
            _saving = false;
            validErrNorm = true;
          });
        }
      });
    } else {
      setState(() {
        validErrNorm = true;
      });
    }
  }

  void _getPenjamin() async {
    Api.getAllPenjamin().then((response) {
      var result = json.decode(response.body);
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        dataPenjamin = list.map((model) => MPenjamin.fromMap(model)).toList();
        print(dataPenjamin[2].penjaminNama);
      });
    });
  }

  var myFormat = DateFormat('dd MMM yyyy');
  var date = DateTime.now();
  Future<String> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1880, 1),
        lastDate: DateTime(2101));
//    return myFormat.format(picked);
    if (picked == null) {
      print('silahkan pilih tgl');
    } else {
      setState(() {
        date = picked;
        _typeAheadController.text = myFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool setting = true;
    if (brightness == Brightness.dark) {
      setting = true;
    } else {
      setting = false;
    }
    initializeDateFormatting('in', null);
    DateTime parsedDate = DateTime.now();
    bool step0 = false;
    bool step1 = false;
    bool step2 = false;
    bool step3 = false;
    if (currentStep == 0) {
      step0 = true;
    } else if (currentStep == 1) {
      step0 = true;
      step1 = true;
    } else if (currentStep == 2) {
      step0 = true;
      step1 = true;
      step2 = true;
    } else if (currentStep == 3) {
      step0 = true;
      step1 = true;
      step2 = true;
      step3 = true;
    } else if (currentStep == 4) {
      step0 = true;
      step1 = true;
      step2 = true;
      step3 = true;
    }
    var today = DateTime.now();
    var width = MediaQuery.of(context).size.width;
    var tglBooking =
        DateFormat("EEEE, dd MMM yyyy", 'in').format(_selectedDateBook);
    var widget1 = MediaQuery.of(context).size.height - 230;
    var widget2 = MediaQuery.of(context).size.height - 320;

    int hourseSetting = dataSetting;
    var kedatanganJam =
        int.parse(jamBukaDokter.substring(0, 2)) - hourseSetting;
    var menit = jamBukaDokter.substring(2, 5);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Booking',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
              padding: EdgeInsets.all(0),
//              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Stepper(
                        steps: [
                          Step(
                            isActive: step0,
                            state: StepState.indexed,
                            title: const Text(''),
                            content: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('No Rekam Medis',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(noRekamMedis)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('Nama Pasien',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(namaPasien)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Alamat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                    ),
                                                    text: alamatPasien),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xFFFF000000)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            'Pilih Penjamin Pasien / Metode Pembayaran'),
                                        Container(
                                          height: 5,
                                        ),
                                        Container(
                                          key: keyButton,
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: showValidBoxIdPenjamin
                                                    ? Colors.red
                                                    : Colors.grey,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: dataPasien.isEmpty
                                              ? DropdownButtonFormField<String>(
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          hintText: ''),
                                                  hint: new Text(
                                                    "Pilih Penjamin",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  value: penjaminPasien,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      penjaminPasien = newValue;
                                                    });
                                                    _onchangePenjamin(newValue);
                                                  },
                                                  items: dataPenjamin
                                                      .map((MPenjamin item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: item.penjaminId
                                                          .toString(),
                                                      child: new Text(
                                                        item.penjaminNama
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              : null,
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Container(
                                            child: showValidBoxIdPenjamin
                                                ? Text(
                                                    'Silahkan pilih penjamin',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                : Container()),
                                        Container(
                                          height: 15,
                                        ),
                                        showNumberAsuransi
                                            ? Column(
                                                children: <Widget>[
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Nomor Asuransi')),
                                                  Container(
                                                    height: 5,
                                                  ),
                                                  new TextFormField(
                                                    controller:
                                                        idNumberPenjaminController,
                                                    validator: (String arg) {
                                                      if (arg.length < 1)
                                                        return '* Silahkan isi nomor asuransi anda';
                                                      else
                                                        return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: '',
//                                                        errorText: showValidIdAsuransi
//                                                            ? 'Silahkan masukkan nomor asuransi'
//                                                            : null
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        Container(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: step1,
                            state: StepState.indexed,
                            title: const Text(''),
                            content: Container(
                              height: widget1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('No Rekam Medis',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(noRekamMedis)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('Nama Pasien',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(namaPasien)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Alamat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[800]),
                                                    text: alamatPasien),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.1,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Color(0xFFFF000000)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Pilih Poliklinik',
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: ListView.builder(
                                          key: keyButton3,
                                          itemCount: listPoliKlinik.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () => _selectedPoli(
                                                  listPoliKlinik[index].unitId,
                                                  listPoliKlinik[index]
                                                      .unitNama,
                                                  listPoliKlinik[index]
                                                      .mInstalasiId),
                                              child: Card(
                                                elevation: 3,
                                                child: Container(
                                                  decoration: BoxDecoration(
//                                                  color: Colors.cyan,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3.0,
                                                      vertical: 3.0),
                                                  child: ListTile(
                                                    title: Text(
                                                      listPoliKlinik[index]
                                                          .unitNama,
                                                      style:
                                                          TextStyle(fontSize: 13
//                                                          color: Colors.white
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                  Container(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Step(
                            isActive: step2,
                            state: StepState.indexed,
                            title: const Text(''),
                            content: Container(
                              height: widget1,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('No Rekam Medis',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(noRekamMedis)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('Nama Pasien',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            Text(namaPasien)
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Alamat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[800]),
                                                    text: alamatPasien),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Color(0xFFFF000000)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      key: keyButton4,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Pilih Jadwal Berobat',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            Text(
                                              DateFormat(
                                                      "EEEE, dd MMM yyyy", 'in')
                                                  .format(_selectedDateBook),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                        HorizontalCalendar(
                                          height: 80,
                                          selectedDateTextStyle: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          monthTextStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                          dateTextStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          weekDayFormat: '',
                                          firstDate:
                                              parsedDate.add(Duration(days: 1)),
                                          lastDate: parsedDate.add(
                                            Duration(days: 7),
                                          ),
                                          onDateSelected: _dateSelect,
                                          //pass other properties as required
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Pilih Dokter',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: listDokter == null
                                          ? Center(
                                              child: Text(
                                              'Data tidak ada \n Silahkan Pilih tanggal lain',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey[400]),
                                            ))
                                          : listDokter.length == 0
                                              ? Text('Silahkan pilih tanggal')
                                              : ListView.builder(
                                                  itemCount: listDokter.length,
                                                  key: keyButton5,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DateTime now =
                                                        DateTime.now();
                                                    String formattedDate =
                                                        DateFormat('kk')
                                                            .format(now);
                                                    var jamAkhir = listDokter[
                                                            index]
                                                        .jadwalpraktekJamAwal
                                                        .substring(0, 2);
                                                    bool jam = false;
                                                    if (int.parse(jamAkhir) >=
                                                        int.parse(
                                                            formattedDate)) {
                                                      jam = true;
                                                    }
                                                    return InkWell(
                                                      onTap: () => _getNoRegistrasi(
                                                          listDokter[index]
                                                              .pegawaiNama,
                                                          listDokter[index]
                                                              .mPegawaiId,
                                                          listDokter[index]
                                                              .jadwalpraktekId,
                                                          listDokter[index]
                                                              .jadwalpraktekJamAwal),
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
//                                                  color: Colors.cyan,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      3.0,
                                                                  vertical:
                                                                      3.0),
                                                          child: ListTile(
                                                            title: Text(
                                                              listDokter[index]
                                                                  .pegawaiNama,
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                            trailing: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      listDokter[
                                                                              index]
                                                                          .jadwalpraktekJamAwal
                                                                          .substring(
                                                                              0,
                                                                              5),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_downward,
                                                                    size: 12,
                                                                  ),
                                                                  Text(
                                                                    listDokter[
                                                                            index]
                                                                        .jadwalpraktekJamAkhir
                                                                        .substring(
                                                                            0,
                                                                            5),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                  Container(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Step(
                            isActive: step3,
                            state: StepState.indexed,
                            title: const Text(''),
                            content: Column(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Selamat Pendaftaran Berhasil',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      Text(
                                        namaPoli,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Container(
                                        height: 5,
                                      ),
                                      Text(
                                        namaDokter,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Container(
                                        height: 20,
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
                                            width: 100,
                                            height: 50,
                                            decoration: new BoxDecoration(
                                                color: Colors
                                                    .red, //new Color.fromRGBO(255, 0, 0, 0.0),
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(40.0))),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  noAntrian_data,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontFamily:
                                                          "WorkSansSemiBold",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                      ),
                                      Container(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(10.0))),
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
                                                width: 140,
                                                height: 140,
//                                      color: Colors.black2,
                                                child: QrImage(
                                                  data: kodeBooking_data
                                                      .toUpperCase(),
                                                  version: QrVersions.auto,
                                                  size: 300.0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              kodeBooking_data.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('$tglBooking',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(jamBukaDokter.substring(0, 5),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Text(
                                            'Anda Harus Checkin/Konfirmasi Sebelum',
                                            textAlign: TextAlign.center,
                                          )),
                                      Text(
                                        '$tglBooking Jam $kedatanganJam$menit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'WorkSansSemiBold',
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        currentStep: currentStep,
                        onStepContinue: next,
//                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                        type: StepperType.horizontal,
                        controlsBuilder: (BuildContext context,
                                {VoidCallback onStepContinue,
                                VoidCallback onStepCancel}) =>
                            currentStep == 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.cyan),
                                      child: InkWell(
                                        key: keyButton2,
                                        onTap: () => next(),
                                        child: Center(
                                            child: Text(
                                          titleButtonLanjut,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                      ),
                                    ),
                                  )
                                : currentStep == 1 || currentStep == 2
                                    ? Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red),
                                        child: InkWell(
                                          onTap: onStepCancel,
                                          child: Center(
                                              child: Text(
                                            titleButtonKembali,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )),
                                        ),
                                      )
                                    : currentStep == 3
                                        ? Container()
                                        : Container()),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _dateSelect(date) {
    setState(() {
      _selectedDateBook = date;
    });
    _getJadwalDokterByTglAndPoli();
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    _formKey.currentState.validate();
    if (penjaminPasien == null && currentStep == 0) {
      setState(() {
        showValidBoxIdPenjamin = true;
      });
    } else {
      if (currentStep == 0 && showNumberAsuransi == true) {
        setState(() {
          showValidBoxIdPenjamin = false;
        });
        if (idNumberPenjaminController.text == '' ||
            idNumberPenjaminController.text == null) {
          setState(() {
            showValidIdAsuransi = true;
          });
        } else {
          currentStep + 1 != 5
              ? goTo(currentStep + 1)
              : setState(() => complete = true);
          setState(() {
            showValidIdAsuransi = false;
            showValidBoxIdPenjamin = false;
          });
        }
      } else {
        if (tutorial) {
          showTutorial3();
        }
        currentStep + 1 != 5
            ? goTo(currentStep + 1)
            : setState(() => complete = true);
      }
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
      setState(() => complete = true);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  void _onchangePenjamin(String newValue) {
    if (tutorial) {
      showTutorial2();
    }
    if (newValue == '1') {
      setState(() {
        showNumberAsuransi = false;
        showValidBoxIdPenjamin = false;
      });
    } else {
      setState(() {
        showNumberAsuransi = true;
      });
    }
  }

  _selectedPoli(idUnit, namaUnit, idInstalasi) {
    if (tutorial) {
      showTutorial4();
    }
    listDokter = [];
    next();
    setState(() {
      namaPoli = namaUnit;
      idUnit_data = idUnit;
      mInstalasiId = idInstalasi;
    });
  }

  void _getNoRegistrasi(pegawaiNama, mPegawaiId, jadwalId, jamBuka) {
    setState(() {
      _saving = !_saving;
      namaDokter = pegawaiNama;
      jamBukaDokter = jamBuka;
    });
    var dateBook = DateFormat("yyyy-MM-dd").format(_selectedDateBook);
    Api.getNoRegistrasi(dateBook, jadwalId).then((response) {
      var result = json.decode(response.body);
      if (result['meta']['success'] == true) {
        int count = int.parse(result['data'][0]['antrian_terakhir']) + 1;
//        print(count);
        var noAntrian = count.toString();
        _alertBookingNow(pegawaiNama, noAntrian, mPegawaiId, jadwalId);
        setState(() {
          noAntrian_data = noAntrian;
          _saving = !_saving;
        });
        if (tutorial) {
          showTutorial6();
        }
      }
    });
  }

  _alertBookingNow(namaDokter, noAntrian, mPegawaiId, jadwalId) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool setting = true;
    if (brightness == Brightness.dark) {
      setting = true;
    } else {
      setting = false;
    }
    var width = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
          title: new Text(
            "Apakah anda yakin melakukan pendaftaran",
            style: TextStyle(fontSize: 14),
          ),
          content: new Container(
            width: width,
            height: 175,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tanggal Booking',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      DateFormat("EEEE, dd MMM yyyy", 'in')
                          .format(_selectedDateBook),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('No Rekam Medis',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      noRekamMedis,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Nama Pasien',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(namaPasien, style: TextStyle(fontSize: 12))
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Alamat',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Container(
                      width: 10,
                    ),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: alamatPasien),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Poli',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      namaPoli,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Dokter',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(namaDokter,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12))),
                Container(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Estimasi Nomor Antrian',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12)),
                    Text(noAntrian,
                        key: keyButton6,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
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
              child: new Text(
                "Iya",
              ),
              onPressed: () {
                _bookingNow(mPegawaiId, jadwalId, noAntrian);
              },
            ),
          ],
        ));
      },
    );
  }

  void _bookingNow(mPegawaiId, jadwalId, noAntrian) {
    setState(() {
      _saving = !_saving;
    });
    Map data = {
      'tanggal_masuk': _selectedDateBook.toString(),
      'm_unit_id': namaPasien,
      'm_unit_id': idUnit_data,
      'm_pasien_id': pasienId,
      'm_pegawai_id': mPegawaiId,
      'm_penjamin_id': penjaminPasien,
      'm_kelas_id': '1',
      'm_shift_id': '0',
      'm_nonpasien_id': '0',
      'm_instalasi_id': mInstalasiId,
      'pendaftaran_status': '',
      't_jadwalpraktek_id': jadwalId,
      'pendaftaran_aktif': 'y',
//      'no_antrian_dokter': noAntrian,
      'tgl_booking': DateTime.now().toString(),
      'kodebooking': kodeBooking_data.toUpperCase(),
      'statusbooking': 'BOOKING',
      "no_registrasi": "",
      "status_kunjungan": "L",
      "pendaftaran_created_date": DateTime.now().toString(),
      "pendaftaran_created_by": "Android"
    };
    Navigator.of(context, rootNavigator: true).pop();
    var body = json.encode(data);
    Api.bookingPendaftaran(body).then((response) {
      var result = json.decode(response.body);
      if (result['meta']['success'] == true) {
        setState(() {
          _saving = !_saving;
        });
        next();
        Flushbar(
          title: "Sukses",
          message: "Booking terlah berhasil",
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        )..show(context);
      } else {
        setState(() {
          _saving = !_saving;
        });
        Flushbar(
          title: "Gagal",
          message: "Password Salah !!!",
          duration: Duration(seconds: 5),
          backgroundColor: Colors.amber,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.warning,
            color: Colors.white,
          ),
        )..show(context);
      }
    });
  }
}
