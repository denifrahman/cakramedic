import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://centerprivat.com/api-absensi/";

class apiLogin {
  static Future loginPost(body) {
    var url = baseUrl + "auth/loginAbsensi";
    return http.post(url,body: body);
  }
}
class apiChekVersion {
  static Future getNewVersion() {
    var url = baseUrl + "t_chek_version/getnewVersion";
    return http.get(url);
  }
}