import 'dart:convert';
import 'dart:ui';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:cakramedic/screens/page_unit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/screens/page_booking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cakramedic/screens/page_profile_faskes.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class widget_home_menu extends StatefulWidget {
  widget_home_menu({Key key}) : super(key: key);

  @override
  _widget_home_menuState createState() => _widget_home_menuState();
}

class _widget_home_menuState extends State<widget_home_menu> {


  String akunpasien_no_rm, akunpasien_nama_akun,akunpasien_no_telpn;
  final Map<String, String> data = {};

  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();


  @override
  void initState() {
    _getDataPasien();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkIntroducing() async {
    String isIntro = await LocalStorage.sharedInstance.readValue('introLinkBooking');
    print(isIntro);
    if(isIntro == null){
      initTargets();
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    }
  }
  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
  }
  void showTutorial() {
    TutorialCoachMark(context,
        targets: targets,
        colorShadow: Colors.cyan,
        paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
//          print("finish");
          String setting_finger = '{"introLinkBooking":"true"}';
          LocalStorage.sharedInstance
              .writeValue(key: 'introLinkBooking', value: setting_finger);
        }, clickTarget: (target) {
          print(target.identify);
          if(target.identify == 'Target 2'){
          }
        }, clickSkip: () {
//          print("skip");
//          String setting_finger = '{"intro":"true"}';
//          LocalStorage.sharedInstance
//              .writeValue(key: 'intro', value: setting_finger);
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
                    "Feature Booking",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Anda dapat melakaukan booking online di menu ini, Pilih penjamin, pilih jadwal dokter selesai, anda sudah mendapatkan kode booking ",
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


  _openBooking() {
    Navigator.push(
      context,
      ScaleRoute(page: page_booking()),
    );
  }

  _openJadwalDokter() {
    Navigator.push(
      context,
      ScaleRoute(page: page_unit()),
    );
  }

  _openProfileFaskes() {
    Navigator.push(
      context,
      ScaleRoute(page: page_profile_faskes()),
    );
  }
  _getDataPasien() async{
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var result = json.decode(dataSession)['data'];
    data["akunpasien_no_rm"] = result['akunpasien_no_rm'];
    data["akunpasien_nama_akun"] = result['akunpasien_nama_akun'];
    data["akunpasien_no_telpn"] = result['akunpasien_no_telpn'];
    checkIntroducing();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
//        color: Colors.grey.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => _openProfileFaskes(),
                  child: new Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(bottom: 6),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        gradient: new LinearGradient(
                            colors: [
                              Colors.pink.withOpacity(0.1),
                              Colors.white
                            ],
                            begin: const FractionalOffset(7.0, 10.1),
                            end: const FractionalOffset(0.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: new Center(
                        child:
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidClock, color: Colors.pink,),
                          onPressed: () => _openProfileFaskes(),
                        ),
                      )),
                ),
                Text(
                  'Faskes',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                new Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      gradient: new LinearGradient(
                          colors: [
                            Colors.orange.withOpacity(0.1),
                            Colors.white
                          ],
                          begin: const FractionalOffset(7.0, 10.1),
                          end: const FractionalOffset(0.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: new Center(
                      child: IconButton(
                        key: keyButton,
                        icon: Icon(
                          FontAwesomeIcons.bookMedical, color: Colors.orange,),
                        onPressed: () => _openBooking(),
                      ),
                    )),
                Text(
                  'Booking',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                new Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      gradient: new LinearGradient(
                          colors: [
                            Colors.blueAccent.withOpacity(0.1),
                            Colors.white
                          ],
                          begin: const FractionalOffset(7.0, 10.1),
                          end: const FractionalOffset(0.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: new Center(
                      child:
                      IconButton(
                        icon: Icon(FontAwesomeIcons.solidClock,
                          color: Colors.blueAccent,),
                        onPressed: () => _openJadwalDokter(),
                      ),
                    )),
                Text(
                  'Jadwal',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                new Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      gradient: new LinearGradient(
                          colors: [
                            Color(0xff00b894).withOpacity(0.1),
                            Colors.white
                          ],
                          begin: const FractionalOffset(7.0, 10.1),
                          end: const FractionalOffset(0.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: new Center(
                      child:
                      IconButton(
                        icon: Icon(FontAwesomeIcons.externalLinkSquareAlt,
                          color: Color(0xff00b894),),
                        onPressed: () => _modalBottomSheetMenu(context, data),
                      ),
                    )),
                Text(
                  'Lainnya',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _modalBottomSheetMenu(context,data) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.grey.withOpacity(0.7),
      context: context,
      builder: (builder) {
        var brightness = MediaQuery.of(context).platformBrightness;
        bool setting = false;
//        if(brightness == Brightness.dark){
//          setting = true;
//        }else{
//          setting = false;
//        }
        return BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: new Container(
              height: MediaQuery.of(context).size.height - 200,
              decoration: new BoxDecoration(
                  color: setting?Colors.grey[700].withOpacity(0.8):Colors.white.withOpacity(0.8),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(10.0))),
                        width: 50,
                        height: 10,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () => _modalKartuPasien(context,data),
                                child: new Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(bottom: 6),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      gradient: new LinearGradient(
                                          colors: [
                                            Color(0xff00cec9).withOpacity(0.1),
                                            Colors.white
                                          ],
                                          begin:
                                              const FractionalOffset(7.0, 10.1),
                                          end: const FractionalOffset(0.0, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: new Center(
                                      child: Icon(
                                        FontAwesomeIcons.addressCard,
                                        size: 24,
                                        color: Color(0xff00cec9),
                                      ),
                                    )),
                              ),
                              Text(
                                'Kartu Pasien',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
//                        Container(
//                          child: Column(
//                            children: <Widget>[
//                              InkWell(
////                                onTap: () => _modalBottomSheetMenu(context),
//                                child: new Container(
//                                    height: 50,
//                                    width: 50,
//                                    margin: EdgeInsets.only(bottom: 6),
//                                    decoration: new BoxDecoration(
//                                      borderRadius: BorderRadius.all(
//                                          Radius.circular(30.0)),
//                                      gradient: new LinearGradient(
//                                          colors: [
//                                            Color(0xffee5253).withOpacity(0.1),
//                                            Colors.white
//                                          ],
//                                          begin:
//                                              const FractionalOffset(7.0, 10.1),
//                                          end: const FractionalOffset(0.0, 0.0),
//                                          stops: [0.0, 1.0],
//                                          tileMode: TileMode.clamp),
//                                    ),
//                                    child: new Center(
//                                      child: Icon(
//                                        FontAwesomeIcons.bed,
//                                        size: 24,
//                                        color: Color(0xffee5253),
//                                      ),
//                                    )),
//                              ),
//                              Text(
//                                'Informasi\nKamar Inap',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(fontSize: 13),
//                              )
//                            ],
//                          ),
//                        ),
//                        Container(
//                          child: Column(
//                            children: <Widget>[
//                              InkWell(
////                                onTap: () => _modalBottomSheetMenu(context),
//                                child: new Container(
//                                    height: 50,
//                                    width: 50,
//                                    margin: EdgeInsets.only(bottom: 6),
//                                    decoration: new BoxDecoration(
//                                      borderRadius: BorderRadius.all(
//                                          Radius.circular(30.0)),
//                                      gradient: new LinearGradient(
//                                          colors: [
//                                            Color(0xff576574).withOpacity(0.1),
//                                            Colors.white
//                                          ],
//                                          begin:
//                                              const FractionalOffset(7.0, 10.1),
//                                          end: const FractionalOffset(0.0, 0.0),
//                                          stops: [0.0, 1.0],
//                                          tileMode: TileMode.clamp),
//                                    ),
//                                    child: new Center(
//                                      child: Icon(
//                                        FontAwesomeIcons.capsules,
//                                        size: 24,
//                                        color: Color(0xff576574),
//                                      ),
//                                    )),
//                              ),
//                              Text(
//                                'Antrian Obat',
//                                style: TextStyle(fontSize: 13),
//                              )
//                            ],
//                          ),
//                        ),
                      ],
                    ),
                  ],
                ),
              )),
        );
      });
}

 void _modalKartuPasien(context,data) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.grey.withOpacity(0.7),
      context: context,
      builder: (builder) {
        return new Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.grey,
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(10.0))),
                      width: 50,
                      height: 10,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(0),
                            height: 200,
                            width: MediaQuery.of(context).size.width - 10,
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    'assets/kartu_nama.png',
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(data['akunpasien_nama_akun'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontFamily: "LinoWrite")),
                                    subtitle: Text(data['akunpasien_no_telpn'],
                                        style: TextStyle(
                                            color: Colors.grey,)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 60,
                                  right:50,
                                  child: QrImage(
                                    data: data['akunpasien_no_rm'],
                                    version: QrVersions.auto,

                                    size: 100.0,
                                    backgroundColor: Colors.white,
                                  ),
                                ),Positioned(
                                  bottom: 50,
                                  left: 25,
                                  child: Text(data['akunpasien_no_rm'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "LinoWrite")),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 25,
                                  child: Text('Charlie Hospital',
                                      style: TextStyle(
                                          color: Colors.cyan,
                                          fontSize: 24,
                                          fontFamily: "WorkSansSemiBold")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
        );
      });
}

