import 'package:get/route_manager.dart';

import 'page/home.dart';
import 'page/login.dart';

class RouteConfig {
  static final String home = "/";
  static final String login = "/login";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: login, page: () => LoginPage())
  ];
}
