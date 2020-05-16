import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flushbar/flushbar.dart';

class page_pendaftaran_pasien extends StatefulWidget {
  page_pendaftaran_pasien({Key key}) : super(key: key);

  @override
  _page_pendaftaran_pasienState createState() {
    return _page_pendaftaran_pasienState();
  }
}

class _page_pendaftaran_pasienState extends State<page_pendaftaran_pasien> {

  TextEditingController inputNamaController = new TextEditingController();
  TextEditingController inputEmailController = new TextEditingController();
  TextEditingController inputNoTelpController = new TextEditingController();
  TextEditingController inputPasswordController = new TextEditingController();
  TextEditingController inputRePasswordController = new TextEditingController();
  TextEditingController inputNoRmController = new TextEditingController();
  final TextEditingController tahunLahirController = new TextEditingController();
  final TextEditingController tanggalLahirController = new TextEditingController();
  final TextEditingController bulanLahirController = new TextEditingController();

  bool validMakun = false;
  bool validMpasien = false;
  String mPasienId = "";
  String mPasienAktif = "";
  bool validTelp = false;
  bool validEmail = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  bool _saving= false;
  @override
  void initState() {
    super.initState();
  }
  double screenHeight;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendaftaran'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: singUpCard(),
          ),
        ),
      ),
    );
  }
  Widget singUpCard() {
    screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 50),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Daftar Akun",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: inputNoRmController,
                    validator: (String arg) {
                      if(arg.length < 1)
                        return 'No Rekam Medis harus di isi';
                      else if(validMpasien)
                        return 'No Rekam Medis tidak terdaftar / tanggal lahir anda tidak sesuai';
                      else if(!validMakun)
                        return 'Akun sudah terdaftar silahkan login';
                    },
                    onChanged: (value){_chekNorm(value);},
                    decoration: InputDecoration(
                        errorText: validMpasien?'No Rekam Medis tidak terdaftar':null,
                        labelText: "No Rekam Medis", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text('Tanggal Lahir', style: TextStyle(color:Colors.grey),)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child:Row(
                        children: <Widget>[
                          Expanded(
                            flex:1,
                            child: Container(
                              width: 50,
                              child: TextFormField(
                                controller: tanggalLahirController,
                                validator: (String arg) {
                                  if(arg.length < 2)
                                    return '*';
                                  else
                                    return null;
                                },
                                maxLength: 2,
                                onChanged: (value){_chekNorm(value);},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Tanggal',
                                ),
                              ),
                            ),
                          ),
                          Container(width: 5,),
                          Expanded(
                            flex:1,
                            child: Container(
                              width: 50,
                              child: TextFormField(
                                controller: bulanLahirController,
                                validator: (String arg) {
                                  if(arg.length < 2)
                                    return '*';
                                  else
                                    return null;
                                },
                                maxLength: 2,
                                onChanged: (value){_chekNorm(value);},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Bulan',
                                ),
                              ),
                            ),
                          ),
                          Container(width: 5,),
                          Expanded(
                            flex:2,
                            child: Container(
                              width: 100,
                              child: TextFormField(
                                controller: tahunLahirController,
                                validator: (String arg) {
                                  if(arg.length < 4)
                                    return '*';
                                  else
                                    return null;
                                },
                                maxLength: 4,
                                onChanged: (value){_chekNorm(value);},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Tahun',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: inputNamaController,
                    validator: (String arg) {
                      if(arg.length < 1)
                        return 'Nama harus di isi';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Nama", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: inputEmailController,
                    validator: validateEmail,
//                    onChanged: (value){_chekEmail(value);},
                    decoration: InputDecoration(
                        labelText: "Email", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: inputNoTelpController,
                    onChanged: (value){_chekNoTelp(value);},
                    validator: validatePhone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "No Telp", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: inputPasswordController,
                    validator: (String arg) {
                      if(arg.length < 6)
                        return 'Password minimal harus 6 karakter';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Password", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: inputRePasswordController,
                    validator: (String arg) {
                      if(inputPasswordController.text != arg)
                        return 'Password tidak sama';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Re-Password", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Daftar"),
                        color: Colors.cyan,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 110, right: 110, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          _daftarPasien();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  _chekNorm(value) {
    Api.getByNoRm(inputNoRmController.text).then((response){
      var result = json.decode(response.body);
      if(result['data'] != null){
        print('data ada m_akun');
        setState(() {
          validMakun = false;
        });
      }else{
        print('data tidak ada m_akun');
        setState(() {
          validMakun = true;
        });
      }
    });
    var tglLahir = tahunLahirController.text+"-"+bulanLahirController.text+"-"+tanggalLahirController.text;
    if(tglLahir != '--'){
    Api.getDataPasienByNoRm(inputNoRmController.text, tglLahir).then((response){
      var result = json.decode(response.body);
      print(result);
      if(result['data'] != null){
        print(result['data'][0]['pasien_aktif']);
        setState(() {
          validMpasien= false;
          mPasienId = result['data'][0]['pasien_id'];
          mPasienAktif=result['data'][0]['pasien_aktif'];
        });
      }else{
        print('data tidak ada m_pasien');
        setState(() {
          validMpasien= true;
        });
      }
    });
    }
  }

  void _daftarPasien() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _saving = false;
      });
//    If all data are correct then save data to out variables
      var tglLahir = tahunLahirController.text+"-"+bulanLahirController.text+"-"+tanggalLahirController.text;
      Map data = {
        'akunpasien_no_rm': inputNoRmController.text,
        'akunpasien_nama_akun': inputNamaController.text,
        'akunpasien_no_telpn': inputNoTelpController.text,
        'akunpasien_email': inputEmailController.text,
        'akunpasien_password': inputPasswordController.text,
        'akunpasien_rep_password': inputRePasswordController.text,
        'akunpasien_created_by': inputNamaController.text,
        'akunpasien_created_date':DateTime.now().toString(),
        'akunpasien_aktif':'t',
        'akunpasien_tgl_lahir':tglLahir,
        "m_pasien_id":mPasienId
      };
      var body = json.encode(data);
      Api.daftarPasienBaru(body).then((response){
        var result = json.decode(response.body);
        print(result);
        if(result['meta']['success'] == true){
          setState(() {
            _saving= false;
          });
          Navigator.pop(context);
          Flushbar(
            title: "Sukses",
            message: "Pendaftran telah berhasil",
            duration: Duration(seconds: 15),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          )..show(context);
        }else{
          setState(() {
            _saving= false;
          });
        }
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    _chekEmail(value);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else if(!validEmail)
      return 'Email Sudah digunakan';
    else
      return null;
  }

  String validatePhone(String value) {
    RegExp regx = RegExp(r"^[0-9]*$",caseSensitive: false);
    if(value.length < 1)
      return 'Telpon harus di isi';
    else if (!regx.hasMatch(value))
      return 'Data harus angka';
    else if(validTelp != true)
      return 'Nomor telpone sudah terdaftar';
    else
      return null;
  }

  void _chekNoTelp(String value) {
    Api.chekNoTelp(value).then((response){
      var result = json.decode(response.body);
      if(result['data'] == null ){
        print(result['data']);
        setState(() {
          validTelp = true;
        });
      }else{
        setState(() {
          validTelp = false;
        });
      }
    });
  }

  void _chekEmail(String value) {
    Map data = {
      'email': value,
    };
    var body = json.encode(data);
    Api.chekNoEmail(body).then((response){
      var result = json.decode(response.body);
//      print(result);
      if(result['data'] == null ){
//        print(result['data']);
        setState(() {
          validEmail = true;
        });
      }else{
        setState(() {
          validEmail = false;
        });
      }
    });
  }


}