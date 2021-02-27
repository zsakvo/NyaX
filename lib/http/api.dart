import 'http_request.dart';

class API {
  static const BASE_URL = "https://app.hbooker.com";
  static const LOGIN = '/signup/login';

  static Future<dynamic> login({name, pwd}) async {
    return DioUtil().get(url: LOGIN, tag: 'login', params: {
      'login_name': name,
      'passwd': pwd,
      'app_version': "2.7.036",
      'device_token': "ciweimao_nyax"
    }).then((res) async {
      return res;
    });
  }
}
