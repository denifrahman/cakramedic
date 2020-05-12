import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://centerprivat.com/api-absensi/m_pelanggan";

class ApiProfile {
  static Future simpanProfile(body) {
    var url = baseUrl + "/simpanProfile";
    return http.post(url,body: body);
  }
}
