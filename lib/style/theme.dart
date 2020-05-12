import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color(0xFF2193b0);
  static const Color loginGradientEnd = const Color(0xFF2193b0);
  static const Color backgroundWhite = const Color(0xFFFFF);
  static const Color themesBasic = const Color(0xFF009688);
  static const Color transparant = const Color(0xFFfff7db30);
  static const Color darkThemeBasic = const Color(0xFF2193b0);
  static const Color headerPage = const Color(0xFFffffff);
  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class TextStyles {
  static const TextStyle baseTextStyle = TextStyle(fontFamily: 'Poppins');
//final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffd4d4d4),
      fontSize: 9.0,
      fontWeight: FontWeight.w400);
  static final planetThumbnail = new Container(
    margin: new EdgeInsets.only(right: 100),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage('assets/icons/icn_twitter.png'),
      height: 92.0,
      width: 92.0,
    ),
  );
  static final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 15.0);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Color(0xFFffffff),
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      fontFamily: "WorkSansSemiBold");

  static final textUang = baseTextStyle.copyWith(
      color: Color(0xFF006455),
      fontSize: 18.0,
      fontWeight: FontWeight.w400,);
  static final textDeskripsiMateri = baseTextStyle.copyWith(
      color: Color(0xFFffffff),
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      fontFamily: "WorkSansSemiBold");

}
