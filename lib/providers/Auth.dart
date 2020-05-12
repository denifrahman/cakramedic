import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://centerprivat.com/api-absensi/auth";

class ApiAuth {
  static Future chekKeyGuruPost(String idGuru,String key) {
    var url = baseUrl + "/chekKeyGuru/"+key+'/'+idGuru;
    return http.get(url);
  }
}