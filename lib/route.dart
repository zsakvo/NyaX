import 'package:get/route_manager.dart';
import 'package:nyax/page/book_detail.dart';
import 'package:nyax/page/discount.dart';
import 'package:nyax/page/free.dart';
import 'package:nyax/page/rank.dart';

import 'page/home.dart';
import 'page/login.dart';

class RouteConfig {
  static final String home = "/";
  static final String login = "/login";
  static final String bookDetail = "/bookDetail";
  static final String rank = "/rank";
  static final String discount = "/discount";
  static final String free = "/free";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: bookDetail, page: () => BookDetailPage()),
    GetPage(name: rank, page: () => RankPage()),
    GetPage(name: discount, page: () => DiscountPage()),
    GetPage(name: free, page: () => FreePage())
  ];
}
