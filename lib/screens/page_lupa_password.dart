import 'dart:convert';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flushbar/flushbar.dart';
import '../style/theme.dart' as Theme;

class page_lupa_password extends StatefulWidget {
  page_lupa_password({Key key}) : super(key: key);

  @override
  _page_lupa_passwordState createState() {
    return _page_lupa_passwordState();
  }
}

class _page_lupa_passwordState extends State<page_lupa_password> {
  @override
  void initState() {
    super.initState();
  }

  bool _saving = false;
  bool validMakun = false;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Lupa Password'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _saving,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 80,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Theme.Colors.backgroundWhite,
                            Theme.Colors.backgroundWhite,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 3.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.repeated),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Column(
                              children: <Widget>[
                                new Image(
                                    width: 120,
//                      height: 191.0,
                                    fit: BoxFit.fill,
                                    image: new AssetImage('assets/logo.png')),
                                Container(
                                  height: 15,
                                ),
                                Text('CHARLIE HOSPITAL',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )),
                        Container(
                          height: 30,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: new ConstrainedBox(
                              constraints: const BoxConstraints.expand(),
                              child: _buildSignIn(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Password anda akan di kirim ke email anda \n jika email yang terdaftar di sistem kami, \n pastikan memasukkan No RM yang valid!",
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 16.0,
                                            fontFamily: "OpenSans-Regular"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "OpenSans-Regular",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.confirmation_number,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Masukkan nomor RM",
                            hintStyle: TextStyle(
                                fontFamily: "OpenSans-Regular",
                                fontSize: 16.0,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.0, 0.2),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
//                color: Colors.indigo,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "KIRIM PASSWORD",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => _chekNorm()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _chekNorm() {
    if (loginEmailController.text.isEmpty) {
      Flushbar(
        title: "Warning",
        message: "Silahkan isi nomor RM anda",
        duration: Duration(seconds: 5),
        backgroundColor: Colors.orange,
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      )..show(context);
    } else {
      Api.getByNoRm(loginEmailController.text).then((response) {
        var result = json.decode(response.body);
        if (result['data'] != null) {
          print('data ada m_akun');
          _sendEmail(result['data']['akunpasien_email'],result['data']['akunpasien_password']);
          setState(() {
            validMakun = false;
          });
        } else {
          print('data tidak ada m_akun');
          setState(() {
            validMakun = true;
          });
        }
      });
    }
  }

  void _sendEmail(email,password) {
    Map data = {
      'email': email,
      'password': password
    };
    var body = json.encode(data);
    Api.lupaPassword(body).then((response) {
      var result = json.decode(response.body);
      print(result);
    });
  }

  loginButton() {}
}
