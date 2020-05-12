import 'dart:convert';

import 'package:cakramedic/screens/page_bottom_menu.dart';
import 'package:cakramedic/screens/page_portal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:splashscreen/splashscreen.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key key}) : super(key: key);

  @override
  _SplaceScreenState createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  bool showIntro;

  @override
  void initState() {
    _getStting();
    super.initState();
  }

  _getStting() async {
    String themeData = await LocalStorage.sharedInstance.readValue('theme');
    if (themeData == null) {
      setState(() {
        showIntro = true;
      });
    } else {
      showIntro = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: page_portal(),
        title: new Text('Charlie Hospital', style: TextStyle(color: Colors.black, fontSize: 18),),
        image: new Image.asset('assets/logo.png',alignment: Alignment.center,width: 150,),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(color: Colors.green),
        photoSize: 150.0,
        loaderColor: Colors.red);
  }
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "SCHOOL",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/background.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/background.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/background.jpg",
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => page_portal()),
        ModalRoute.withName('/portal'));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
