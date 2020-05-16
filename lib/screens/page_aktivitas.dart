import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/widgets/widget_aktivitas.dart';
import 'package:cakramedic/widgets/widget_antrian.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';


class page_aktivitas extends StatefulWidget {
  page_aktivitas({Key key}) : super(key: key);

  @override
  _page_aktivitasState createState() {
    return _page_aktivitasState();
  }
}

class _page_aktivitasState extends State<page_aktivitas> {
  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  @override
  void initState() {
    super.initState();
    checkIntroducing();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void checkIntroducing() async {
    String isIntro = await LocalStorage.sharedInstance.readValue('introAktivitas');
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
        colorShadow: Colors.cyan[800],
        paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
//          print("finish");
          String setting_finger = '{"introAktivitas":"true"}';
          LocalStorage.sharedInstance
              .writeValue(key: 'introAktivitas', value: setting_finger);
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
                    "Aktivitas",
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
                          image: new AssetImage('assets/tutorial/booking.jpeg'))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Disini anda dapat melihat daftar booking anda, Klik untuk melihat detail booking anda ",
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
                      "Antrian Online",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/tutorial/booking.jpeg'))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Disini anda memungkinkan untuk melihat antrian yang sedang di panggil, anda dengan mudah dapat datang ke rumah sakit tanpa membuang banyak waktu untuk sekedar menunggu antruan",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
//        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
//          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.cyan,
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: EdgeInsets.all(10),
                  indicatorColor: Colors.cyan,
                  indicator:  new BubbleTabIndicator(
                    indicatorHeight: 30.0,
                    indicatorColor: Colors.grey[200],
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    Tab(
                      key: keyButton,
                        child: Text('Aktivitas', style: TextStyle( fontWeight: FontWeight.w400),),
                    ),
                    Tab(
                      key: keyButton2,
                      child: Text('Antrian Online Poliklinik', style: TextStyle( fontWeight: FontWeight.w400),),
                    )
                  ],
                ),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Aktivitas Saya', style: TextStyle(fontSize: 25, letterSpacing: 1,fontFamily: "WorkSansMedium"),),
              Icon(Icons.today,)
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  Expanded(child: widget_aktivitas())
                ],
              ),
              Container(
                  child: Center(
                    child: widget_antrian(),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}