import 'package:cakramedic/utils/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetTotalPasien extends StatelessWidget {
  const WidgetTotalPasien({
    Key key,
    @required this.width,
    @required this.themeNotifier,
  }) : super(key: key);

  final double width;
  final DataProvider themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: width / 1.4,
              child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total Pasien',
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                        Text(
                          themeNotifier.totalPasien_ == null
                              ? ''
                              : themeNotifier.totalPasien_,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    trailing:
                        Icon(FontAwesomeIcons.users, color: Colors.orange),
                  )),
            ),
            Expanded(
              child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      children: <Widget>[
                        Text(
                          'Hari ini',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                        Text(
                          themeNotifier.hariIni_ == null
                              ? ''
                              : themeNotifier.hariIni_,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Laki-laki',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        Text(
                          themeNotifier.pasienLakiLaki_ == null
                              ? ''
                              : themeNotifier.pasienLakiLaki_,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    trailing: Icon(
                      FontAwesomeIcons.male,
                      color: Colors.blue,
                    ),
                  )),
            ),
            Expanded(
              child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Perempuan',
                          style: TextStyle(fontSize: 12, color: Colors.pink),
                        ),
                        Text(
                          themeNotifier.pasienPerempuan_ == null
                              ? ''
                              : themeNotifier.pasienPerempuan_,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    trailing: Icon(
                      FontAwesomeIcons.female,
                      color: Colors.pink,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
