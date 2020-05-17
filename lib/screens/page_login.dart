import 'dart:convert';
import 'dart:io';
import 'package:cakramedic/providers/booking.dart';
import 'package:cakramedic/screens/page_lupa_password.dart';
import 'package:cakramedic/screens/page_pendaftaran_pasien.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/models/chekVersion.dart';
import 'package:cakramedic/providers/Login.dart';
import 'package:cakramedic/screens/page_bottom_menu.dart';
import 'package:cakramedic/widgets/navigation_scale.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../style/theme.dart' as Theme;

class LoginPage extends StatefulWidget {
//  static const routeName = '/login-screen';
  LoginPage({Key key}) : super(key: key);
  final LocalStorage storage = new LocalStorage();
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=idwebdesainer.com.absensi';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  bool isLoggedInBool = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  bool _obscureTextLogin = true;
  bool _saving = false;
  String newVersion;
  String deskripsi;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;
  bool _autoValidate = false;

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
    double.parse(info.version.trim().replaceAll(".", ""));
    print(currentVersion);
    apiChekVersion.getNewVersion().then((response) {
      final Map parsed = json.decode(response.body)['data'];
      final data = ChekVersion.fromMap(parsed);
      setState(() {
        newVersion = data.versionNumber;
        deskripsi = data.deksripsi;
      });
      double newVersionData =
      double.parse(data.versionNumber.trim().replaceAll(".", ""));
      if (newVersionData > currentVersion) {
        _showVersionDialog(context);
      }
    });
  }

  _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

//    final String message = authenticated ? 'Authorized' : 'Not Authorized';
//    print(authenticated);
    if (authenticated) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BottomMenu()),
          ModalRoute.withName('/dashboard'));
    } else {}
  }

  _showVersionDialog(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    var currentVersion = info.version;
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Pembaruan baru tersedia";
        String message =
            "Pembaruan versi tersedia! $newVersion, versi aplikasi anda saat ini adalah $currentVersion. \t "
            "apa yang baru \t  "
            "$deskripsi";
        String btnLabel = "Perbarui";
        String btnLabelCancel = "Nanti";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('Login'),
        ),
        key: _scaffoldKey,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 80,
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
                            padding: EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: <Widget>[
                                new Image(
                                    width: 100,
//                      height: 191.0,
                                    fit: BoxFit.fill,
                                    image: new AssetImage('assets/logo.png')),
                                Container(
                                  height: 15,
                                ),
                                Text('CHARLIE HOSPITAL',
                                    style: TextStyle(
                                        fontSize: 18,
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
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Belum punya akun?",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 16.0,
                                            fontFamily: "OpenSans-Regular"),
                                      ),
                                      Container(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () => _openPagePendaftaran(),
                                        child: Text(
                                          "Daftar Pasien",
                                          style: TextStyle(
                                              color: Colors.cyan[600],
                                              fontSize: 16.0,
                                              decoration:
                                              TextDecoration.underline,
                                              fontFamily: "OpenSans-Regular"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: ()=> _openPageLupaPassword(),
                                    child: Text(
                                      "Lupa Password?",
                                        style: TextStyle(
                                            color: Colors.cyan[600],
                                            fontSize: 16.0,
                                            fontFamily: "OpenSans-Regular"),
                                    ),
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

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    versionCheck(context);
    chekSession();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
//            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
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
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "No Telepon",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.blueGrey),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
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
                        "MASUK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => loginButton()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void chekSession() async {
    String isLoggedIn = await LocalStorage.sharedInstance.readValue('session');
    String settingLocal =
    await LocalStorage.sharedInstance.readValue('setting');
    String themeData =
    await LocalStorage.sharedInstance.readValue('theme');

    if (isLoggedIn != null) {
      if (settingLocal == null) {
        String setting_finger = '{"finger_print":"false"}';
        LocalStorage.sharedInstance
            .writeValue(key: 'setting', value: setting_finger);
      }
      if (themeData == null) {
        String theme = '{"theme":"0"}';
        LocalStorage.sharedInstance
            .writeValue(key: 'theme', value: theme);
      }
      var setting = json.decode(settingLocal);
      if (setting['finger_print'] == 'true') {
        _authenticate();
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomMenu()),
            ModalRoute.withName('/dashboard'));
      }
      setState(() {
        isLoggedInBool = true;
      });
    }
  }

  _openPagePendaftaran() {
    Navigator.push(
      context,
      ScaleRoute(page: page_pendaftaran_pasien()),
    );
  }

  void loginButton() async {
    String settingLocal =
    await LocalStorage.sharedInstance.readValue('setting');
    String themeData =
    await LocalStorage.sharedInstance.readValue('theme');

    if (loginEmailController.text != '' && loginPasswordController.text != '') {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _saving = true;
      });
      Map data = {
        'akunpasien_no_telpn': loginEmailController.text,
        'akunpasien_password': loginPasswordController.text
      };
      var body = json.encode(data);
      Api.loginPost(body).then((response) {
        var result = json.decode(response.body);
        if (result['meta']['success'] == true) {
          LocalStorage.sharedInstance
              .writeValue(key: 'session', value: response.body);

          if (settingLocal == null) {
            String setting_finger = '{"finger_print":"false"}';
            LocalStorage.sharedInstance
                .writeValue(key: 'setting', value: setting_finger);
          }
          if (themeData == null) {
            String theme = '{"theme":"0"}';
            LocalStorage.sharedInstance
                .writeValue(key: 'theme', value: theme);
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomMenu()),
              ModalRoute.withName('/dashboard'));
          setState(() {
            _saving = false;
          });
        } else {
          showInSnackBar("Email Dan Password salah !!!");
          setState(() {
            _saving = false;
          });
        }
      });
    } else {
      showInSnackBar("tidak boleh kosong");
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  _openPageLupaPassword() {
    Navigator.push(
      context,
      ScaleRoute(page: page_lupa_password()),
    );
  }
}
