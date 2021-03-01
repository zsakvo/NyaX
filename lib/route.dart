import 'package:get/route_manager.dart';
import 'package:nyax/page/book_detail.dart';
import 'package:nyax/page/correlation.dart';
import 'package:nyax/page/correlation_list.dart';
import 'package:nyax/page/discount.dart';
import 'package:nyax/page/extra_id_book_list.dart';
import 'package:nyax/page/free.dart';
import 'package:nyax/page/rank.dart';
import 'package:nyax/page/search.dart';

import 'page/home.dart';
import 'page/login.dart';

class RouteConfig {
  static final String home = "/";
  static final String login = "/login";
  static final String bookDetail = "/bookDetail";
  static final String rank = "/rank";
  static final String discount = "/discount";
  static final String free = "/free";
  static final String correlationList = "/correlationList";
  static final String correlation = "/correlation";
  static final String extraIdBookList = "/extraIdBookList";
  static final String search = "/search";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: bookDetail, page: () => BookDetailPage()),
    GetPage(name: rank, page: () => RankPage()),
    GetPage(name: discount, page: () => DiscountPage()),
    GetPage(name: free, page: () => FreePage()),
    GetPage(name: correlationList, page: () => CorrelationListPage()),
    GetPage(name: correlation, page: () => CorrelationPage()),
    GetPage(name: extraIdBookList, page: () => ExtraIdBookListPage()),
    GetPage(name: search, page: () => SearchPage())
  ];
}
