import 'package:cakramedic/utils/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetPendapatan extends StatelessWidget {
  WidgetPendapatan({Key key, this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Container(
      width: width,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Total Pendapatan Tunai',
                      style: TextStyle(fontSize: 15, color: Colors.cyan[800]),
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
              width: width,
              padding: EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0, right: 5),
                      child: Row(
                        children: <Widget>[
                          Text(
                            DateFormat('dd/MMM/yyyy')
                                .format(dataProvider.datePendapatan_)
                                .toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[500]),
                          ),
                          Container(
                            width: 5,
                          ),
                          Text("s/d",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.cyan[800])),
                          Container(
                            width: 5,
                          ),
                          Text(
                            DateFormat('dd/MMM/yyyy')
                                .format(dataProvider.toDatePendapatan_)
                                .toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      dataProvider.pendapatanTotal_.toString() == 'null'
                          ? 'wait...'
                          : dataProvider.pendapatanTotal_.toString(),
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                trailing: InkWell(
                  onTap: () => _selectMonthPendapatan(context),
                  child: Container(
                    margin: EdgeInsets.only(top: 8, right: 5),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.date_range, size: 30, color: Colors.amber),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectMonthPendapatan(BuildContext context) async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: dataProvider.datePendapatan_,
      initialLastDate: dataProvider.toDatePendapatan_,
      firstDate: DateTime(DateTime.now().year - 50, 5),
      lastDate: DateTime(DateTime.now().year + 50, 9),
    );
    if (picked != null && picked.length == 2) {
      dataProvider.setDatePendapatan(picked[0]);
      dataProvider.setToDatePendapatan(picked[1]);
    }
  }
}
