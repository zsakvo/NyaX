import 'http_request.dart';

class API {
  static const BASE_URL = "https://app.hbooker.com";
  static const LOGIN = '/signup/login';
  static const GET_MY_INFO = "/reader/get_my_info";

  //账户登录
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

  //个人信息
  static Future getMyInfo() async {
    var res = await DioUtil().get(url: GET_MY_INFO, tag: 'myInfo', params: {});
    if (res['success']) {
      // var data = json.encode(res['data']);
      // var parseData = myInfoFromJson(data);
      return res;
    } else {
      return null;
    }
  }
}
