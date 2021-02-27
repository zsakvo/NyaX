import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:nyax/global.dart';
import 'package:nyax/page/login.dart';
import 'package:nyax/util/decrypt.dart';

class DioUtil {
  ///同一个 CancelToken 可以用于多个请求，当一个 CancelToken 取消时，所有使用该 CancelToken 的请求都会被取消，一个页面对应一个 CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  Dio _client;

  static final DioUtil _instance = DioUtil._internal();

  factory DioUtil() => _instance;

  Dio get client => _client;

  static final Map<String, dynamic> mixin = {};

  /// 创建 dio 实例对象
  DioUtil._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
          baseUrl: 'https://app.hbooker.com',
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {
            'user-agent': 'Android com.kuangxiangciweimao.novel Nya,Flutter'
          });
      _client = Dio(options);
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  ///
  static void init() {
    GetStorage box = GetStorage();
    var token = box.read("token");
    var account = box.read("account");
    mixin["app_version"] = "2.7.036";
    mixin["device_token"] = "ciweimao_nyax";
    mixin["login_token"] = token;
    mixin["account"] = account;
    G.logger.d(mixin);
  }

  ///Get 网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url 请求参数支持 restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  get({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    return _request(
      url: url,
      params: params,
      method: GET,
      tag: tag,
    );
  }

  ///post 网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url 请求参数支持 restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  post({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    return _request(
      url: url,
      data: data,
      method: POST,
      params: params,
      tag: tag,
    );
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url 请求参数支持 restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  _request({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    //设置默认值
    params = params ?? {};
    method = method ?? 'get';

    options?.method = method;

    options = options ??
        Options(
          method: method,
        );
    FormData formData;

    if (method == GET) {
      params.addAll(mixin);
    } else if (method == POST) {
      data.addAll(mixin);
      formData = FormData.fromMap(data);
    }

    // try {
    CancelToken cancelToken;
    if (tag != null) {
      cancelToken =
          _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
      _cancelTokens[tag] = cancelToken;
    }
    try {
      var response = await _client.request(url,
          data: formData,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      return successCallback(response.data.toString().trim(),
          login: url == '/signup/login');
    } catch (err) {
      Get.snackbar("错误", err.toString(),
          animationDuration: Duration(milliseconds: 500),
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16));
      return {
        'success': false,
        'data': err,
      };
    }
  }

  successCallback(data, {login: false}) {
    var clearData = Decrypt.decrypt2Base64(data);
    if (clearData['code'].toString() == '100000') {
      return {'success': true, 'data': clearData['data']};
    } else {
      if (clearData['code'].toString() == '200100') {
        // CwmRouter.pushNoParams("cwm://LoginPage");
        Get.off(LoginPage());
        var box = GetStorage();
        box.remove("token");
      }
      Get.snackbar("错误", clearData['tip'],
          animationDuration: Duration(milliseconds: 500),
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16));
      return {
        'success': false,
        'data': clearData['tip'],
      };
    }
  }

  errorCallback(HttpError error) {
    Get.snackbar("错误", error.message,
        animationDuration: Duration(milliseconds: 500),
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16));
    return {
      'success': false,
      'data': error.code + "\n" + error.message
    }; //continue
  }
}

class HttpError {
  ///HTTP 状态码
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;

  ///未知错误
  static const String UNKNOWN = "UNKNOWN";

  ///解析错误
  static const String PARSE_ERROR = "PARSE_ERROR";

  ///网络错误
  static const String NETWORK_ERROR = "NETWORK_ERROR";

  ///协议错误
  static const String HTTP_ERROR = "HTTP_ERROR";

  ///证书错误
  static const String SSL_ERROR = "SSL_ERROR";

  ///连接超时
  static const String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";

  ///响应超时
  static const String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";

  ///发送超时
  static const String SEND_TIMEOUT = "SEND_TIMEOUT";

  ///网络请求取消
  static const String CANCEL = "CANCEL";

  String code;

  String message;

  HttpError(this.code, this.message);

  HttpError.dioError(DioError error) {
    message = error.message;
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        code = CONNECT_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        code = RECEIVE_TIMEOUT;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.SEND_TIMEOUT:
        code = SEND_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RESPONSE:
        code = HTTP_ERROR;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.CANCEL:
        code = CANCEL;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.DEFAULT:
        code = UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
    }
  }

  @override
  String toString() {
    return 'HttpError{code: $code, message: $message}';
  }
}
