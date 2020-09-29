import 'dart:convert';
import 'package:cakramedic/widgets/navigation_right.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:cakramedic/widgets/widget_cek_booking_non_pasien.dart';
import 'package:cakramedic/widgets/widget_detail_booking_non_pasien.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cakramedic/models/JenisAntrian.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/date_symbol_data_local.dart';

class page_booking_non_pasien extends StatefulWidget {
  page_booking_non_pasien({Key key}) : super(key: key);

  @override
  _page_booking_non_pasienState createState() {
    return _page_booking_non_pasienState();
  }
}

class _page_booking_non_pasienState extends State<page_booking_non_pasien> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateFormat timeFormat;
  DateTime _selectedDateBook = DateTime.now().add(Duration(days: 1));
  var loketAntrian = new List<JenisAntrian>();
  String nama, noTelp, noKtp, alamat, idJenisAntrian;
  bool _saving = false;

  @override
  void initState() {
    _getPenjamin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getPenjamin() async {
    Api.getLoketAntrian().then((response) {
      var result = json.decode(response.body);
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        loketAntrian = list.map((model) => JenisAntrian.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in', null);
    DateTime parsedDate = DateTime.now();
    // TODO: implement build
    var appBar = AppBar(
      title: Text('Booking Antrian tanpa nomor rekam medis'),
    );
    return Scaffold(
      appBar: appBar,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sudah booking antrian lupa tidak menyimpan? anda bisa melihat antrian anda',
                  style: TextStyle(color: Colors.red[200]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          SlideRightRoute(
                              page: widget_cek_booking_non_pasien()));
                    },
                    color: Colors.orange,
                    child: Text(
                      'Lihat Nomor Antrian',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  'Daftar Antrian Baru',
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Pilih Jadwal Berobat',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      DateFormat("EEEE, dd MMM yyyy", 'in').format(_selectedDateBook),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    )
                  ],
                ),
                HorizontalCalendar(
                  height: 80,
                  selectedDateTextStyle: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w600),
                  monthTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  dateTextStyle: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                  weekDayFormat: '',
                  firstDate: parsedDate.add(Duration(days: 1)),
                  lastDate: parsedDate.add(
                    Duration(days: 7),
                  ),
                  onDateSelected: _dateSelect,
                  //pass other properties as required
                ),
                TextFormField(
                  validator: (String arg) {
                    if (arg.length < 2)
                      return '*';
                    else
                      return null;
                  },
                  maxLength: 50,
                  onChanged: (value) {
                    setState(() {
                      nama = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                TextFormField(
                  validator: (String arg) {
                    if (arg.length < 2)
                      return '*';
                    else
                      return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      noTelp = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telpon',
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  validator: (String arg) {
                    if (arg.length < 16)
                      return '* ktp tidak valid, pastikan 16 digit nomer sesuai';
                    else
                      return null;
                  },
                  maxLength: 16,
                  onChanged: (value) {
                    setState(() {
                      noKtp = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomor KTP',
                  ),
                ),
                TextFormField(
                  validator: (String arg) {
                    if (arg.length < 5)
                      return '* alamat minimal 5 karakter';
                    else
                      return null;
                  },
                  maxLength: 100,
                  onChanged: (value) {
                    setState(() {
                      alamat = value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                  ),
                ),
                Container(
                  height: 15,
                ),
                Text('Pilih Penjamin'),
                Container(
                  height: 5,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration.collapsed(hintText: ''),
                  hint: new Text(
                    "Pilih Penjamin",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onChanged: (String newValue) {
                    _onchangePenjamin(newValue);
                  },
                  items: loketAntrian.map((JenisAntrian item) {
                    return new DropdownMenuItem<String>(
                      value: item.jenisAntrianId.toString(),
                      child: new Text(
                        item.jenisAntrianNama.toString(),
                        style: TextStyle(fontSize: 13),
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              _formKey.currentState.validate();
              _formKey.currentState.save();
              bookingAntrian();
            },
            color: Colors.cyan[800],
            child: Text(
              'Booking',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void bookingAntrian() {
    if(idJenisAntrian != null){
      setState(() {
        _saving = true;
      });
      Map data = {
        'ambil_antrian_tanggal': _selectedDateBook.toString(),
        'm_jenisantrian_id': idJenisAntrian.toString(),
        'm_lokasiantrian_id': idJenisAntrian.toString(),
        'ambil_antrian_aktif': 'y',
        'ambil_nama': nama.toString(),
        'ambil_no_ktp': noKtp.toString(),
        'ambil_no_telp': noTelp.toString(),
        'ambil_alamat': alamat.toString()
      };
      var body = json.encode(data);
      if (_formKey.currentState.validate()) {
        Api.bookingPendaftaranNonPasien(body).then((response) {
          var result = json.decode(response.body);
          if (result['meta']['success'] == true) {
            setState(() {
              _saving = false;
            });
            Navigator.push(
                context,
                ScaleRoute(
                    page: widget_detail_booking_non_pasien(
                  tanggal_booking: DateFormat("yyyy-MM-dd", 'in').format(_selectedDateBook),
                  no_ktp: noKtp,
                )));
            Flushbar(
              title: "Sukses",
              message: "Pendaftran telah berhasil",
              duration: Duration(seconds: 15),
              backgroundColor: Colors.green,
              flushbarPosition: FlushbarPosition.TOP,
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            )..show(context);
          } else {
            setState(() {
              _saving = false;
            });
            Flushbar(
              title: result['meta']['succes'],
              message: result['meta']['status_message'],
              duration: Duration(seconds: 15),
              backgroundColor: Colors.red,
              flushbarPosition: FlushbarPosition.BOTTOM,
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            )..show(context);
          }
        });
      }
    }else{
      Flushbar(
        title: 'Data tidak lengkap',
        message: 'Silahkan lengkapi data',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
      )..show(context);
    }
  }

  void _dateSelect(date) {
    setState(() {
      _selectedDateBook = date;
    });
  }

  void _onchangePenjamin(String newValue) {
    setState(() {
      idJenisAntrian = newValue;
    });
  }
}
