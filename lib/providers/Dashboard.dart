import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://centerprivat.com/api-absensi/dashboard";

class API {
  static Future getSaldo(String id) {
    var url = baseUrl + "/getSaldoById/"+id;
    return http.get(url);
  }
  static Future getMurid(String id) {
    var url = baseUrl + "/getMurid/"+id;
    return http.get(url);
  }
  static Future getPertemuan(String id) {
    var url = baseUrl + "/getPertemuan/"+id;
    return http.get(url);
  }
}