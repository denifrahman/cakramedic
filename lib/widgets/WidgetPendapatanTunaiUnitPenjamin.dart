import 'package:cakramedic/models/m_penjamin.dart';
import 'package:cakramedic/models/m_poli_klinik.dart';
import 'package:cakramedic/utils/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetPendapatanTunaiUnitPenjamin extends StatefulWidget {
  WidgetPendapatanTunaiUnitPenjamin({Key key}) : super(key: key);

  @override
  _WidgetPendapatanTunaiUnitPenjaminState createState() =>
      _WidgetPendapatanTunaiUnitPenjaminState();
}

class _WidgetPendapatanTunaiUnitPenjaminState
    extends State<WidgetPendapatanTunaiUnitPenjamin>
    with SingleTickerProviderStateMixin {
  DateTime datePendapatanUnit =
      DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatanUnit =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  DateTime datePendapatanPenjamin =
      DateTime(DateTime.now().year, DateTime.now().month);
  DateTime toDatePendapatanPenjamin =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  TabController _controller;

  String unitId, penjaminId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Row(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Pendapatan Tunai',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.cyan[800]),
                              ),
                            ),
                            Icon(
                              Icons.monetization_on,
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
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
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
                        height: 150,
                        child: new TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 10, right: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                DateFormat('dd/MMM/yyyy')
                                                    .format(datePendapatanUnit)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[500]),
                                              ),
                                              Container(
                                                width: 5,
                                              ),
                                              Text("s/d",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.cyan[800])),
                                              Container(
                                                width: 5,
                                              ),
                                              Text(
                                                DateFormat('dd/MMM/yyyy')
                                                    .format(
                                                        toDatePendapatanUnit)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[500]),
                                              ),
                                            ],
                                          )),
                                      InkWell(
                                        onTap: () =>
                                            _selectMonthPendapatanUnit(context),
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(top: 8, right: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 30,
                                                  color: Colors.amber),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  dataProvider.listPoliKlinik_.isNotEmpty
                                      ? DropdownButtonFormField<String>(
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          hint: new Text(
                                            "Pilih Unit",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          value: unitId,
                                          onChanged: (String newValue) {
                                            _onchangeUnit(newValue);
                                          },
                                          items: dataProvider.listPoliKlinik_
                                              .map((MPoliKlinik item) {
                                            return new DropdownMenuItem<String>(
                                              value: item.unitId.toString(),
                                              child: new Text(
                                                item.unitNama.toString(),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : Container(),
                                  Text(
                                    dataProvider.pendapatanUnitTotal
                                                .toString() ==
                                            'null'
                                        ? 'Rp 0'
                                        : dataProvider.pendapatanUnitTotal
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, right: 5),
                                        child: DateTime(DateTime.now().year,
                                                        DateTime.now().month) !=
                                                    DateFormat('yyyy-MM-dd').format(
                                                        datePendapatanPenjamin) &&
                                                DateFormat('yyyy-MM-dd').format(
                                                        toDatePendapatanPenjamin) !=
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                    .month +
                                                                1,
                                                            0))
                                            ? Row(
                                                children: <Widget>[
                                                  Text(
                                                    DateFormat('dd/MMM/yyyy')
                                                        .format(
                                                            datePendapatanPenjamin)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.grey[500]),
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
                                                    DateFormat('dd/MMM/yyyy')
                                                        .format(
                                                            toDatePendapatanPenjamin)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.grey[500]),
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
                                            _selectMonthPendapatanPenjamin(
                                                context),
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(top: 8, right: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 30,
                                                  color: Colors.amber),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  dataProvider.dataPenjamin_.isNotEmpty
                                      ? DropdownButtonFormField<String>(
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          hint: new Text(
                                            "Pilih Pejamin",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          value: penjaminId,
                                          onChanged: (String newValue) {
                                            _onchangePenjamin(newValue);
                                          },
                                          items: dataProvider.dataPenjamin_
                                              .map((MPenjamin item) {
                                            return new DropdownMenuItem<String>(
                                              value: item.penjaminId.toString(),
                                              child: new Text(
                                                item.penjaminNama.toString(),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : Container(),
                                  Text(
                                    dataProvider.pendapatanPenjaminTotal
                                                .toString() ==
                                            'null'
                                        ? 'Rp 0'
                                        : dataProvider.pendapatanPenjaminTotal
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
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
    );
  }

  Future<Null> _selectMonthPendapatanUnit(BuildContext context) async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: datePendapatanUnit,
      initialLastDate: toDatePendapatanUnit,
      firstDate: DateTime(DateTime.now().year - 50, 5),
      lastDate: DateTime(DateTime.now().year + 50, 9),
    );
    if (picked != null && picked.length == 2) {
      dataProvider.setDatePendapatanUnit(picked[0]);
      dataProvider.setToDatePendapatanUnit(picked[1]);
    }
  }

  Future<Null> _selectMonthPendapatanPenjamin(BuildContext context) async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: datePendapatanPenjamin,
      initialLastDate: toDatePendapatanPenjamin,
      firstDate: DateTime(DateTime.now().year - 50, 5),
      lastDate: DateTime(DateTime.now().year + 50, 9),
    );
    if (picked != null && picked.length == 2) {
      dataProvider.setDatePendapatanPenjamin(picked[0]);
      dataProvider.setToDatePendapatanPenjamin(picked[1]);
    }
  }

  void _onchangeUnit(String newValue) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setUnitId(newValue);
    dataProvider.getPendapatanUnit();
  }

  void _onchangePenjamin(String newValue) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setPenjaminId(newValue);
    dataProvider.getPendapatanPenjamin();
  }
}
