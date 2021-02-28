import 'http_request.dart';

class API {
  static const BASE_URL = "https://app.hbooker.com";
  static const LOGIN = '/signup/login';
  static const GET_MY_INFO = "/reader/get_my_info";
  static const GET_INDEX_LIST = '/bookcity/get_index_list';
  static const GET_SHELF_LIST = '/bookshelf/get_shelf_list';
  static const GET_SHELF_BOOK_LIST = '/bookshelf/get_shelf_book_list_new';

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

  //书架列表
  static Future<dynamic> getShelfList() async {
    var res = await DioUtil()
        .get(url: GET_SHELF_LIST, tag: 'getShelfList', params: {});
    if (res['success']) {
      return res['data']['shelf_list'];
    } else {
      return null;
    }
  }

  //书架书籍列表
  static Future<dynamic> getShelfBookList({shelfId, page}) async {
    var res = await DioUtil().get(
        url: GET_SHELF_BOOK_LIST,
        tag: 'getShelfBookList',
        params: {
          'count': 100,
          'shelf_id': shelfId,
          'page': page,
          'order': 'last_read_time'
        });
    if (res['success']) {
      var data = res['data']['book_list'];
      return data;
    } else {
      return null;
    }
  }

  //推荐列表
  static Future<dynamic> getIndexList(tabType, {themeType = "NORMAL"}) async {
    var res = await DioUtil().get(
        url: GET_INDEX_LIST,
        tag: 'bookCity',
        params: {'tab_type': tabType, 'theme_type': themeType});
    if (res['success']) {
      var data = res['data']['module_list'];
      // var parseData = bookIndexListFromJson(data);
      return data;
    } else {
      return null;
    }
  }
}
