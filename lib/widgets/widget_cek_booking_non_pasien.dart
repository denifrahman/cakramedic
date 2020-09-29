import 'package:cakramedic/widgets/navigation_right.dart';
import 'package:cakramedic/widgets/widget_detail_booking_non_pasien.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:intl/intl.dart';

class widget_cek_booking_non_pasien extends StatefulWidget {
  widget_cek_booking_non_pasien({Key key}) : super(key: key);

  @override
  _widget_cek_booking_non_pasienState createState() {
    return _widget_cek_booking_non_pasienState();
  }
}

class _widget_cek_booking_non_pasienState extends State<widget_cek_booking_non_pasien> {
  @override
  void initState() {
    super.initState();
  }

  String noKtp;

  @override
  void dispose() {
    super.dispose();
  }

  DateFormat timeFormat;
  DateTime _selectedDateBook = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime parsedDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Booking'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
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
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.push(context, SlideRightRoute(page: widget_detail_booking_non_pasien(tanggal_booking: DateFormat("yyyy-MM-dd", 'in').format(_selectedDateBook), no_ktp: noKtp,)));
            },
            color: Colors.cyan[800],
            child: Text(
              'Cek Booking',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _dateSelect(date) {
    setState(() {
      _selectedDateBook = date;
    });
  }
}
