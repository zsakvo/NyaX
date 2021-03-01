import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/http/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchListLogic extends GetxController {
  final String sKey;
  SearchListLogic(this.sKey);
  dynamic paras;
  List<Book> bookList;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final filterParams = {
    "order": [
      {"name": "默认", "value": ""},
      {"name": "人气", "value": "week_click"},
      {"name": "更新时间", "value": "uptime"},
      {"name": "总推荐", "value": "total_recommend"},
      {"name": "总收藏", "value": "total_favor"},
      {"name": "总月票", "value": "total_yp"},
      {"name": "总点击", "value": "total_click"},
      {"name": "总吐槽", "value": "total_tsukkomi"},
      {"name": "均订", "value": "average_buy"},
      {"name": "字数", "value": "total_word_count"}
    ],
    "filter_word": [
      {"name": "不限", "value": ""},
      {"name": "30w以下", "value": "1"},
      {"name": "30w-50w", "value": "2"},
      {"name": "50w-100w", "value": "3"},
      {"name": "100w-200w", "value": "4"},
      {"name": "200w以上", "value": "5"}
    ],
    "up_status": [
      {"name": "全部", "value": ""},
      {"name": "完本", "value": "1"},
      {"name": "连载", "value": "0"}
    ],
    "is_paid": [
      {"name": "不限", "value": ""},
      {"name": "免费", "value": "0"},
      {"name": "vip", "value": "1"}
    ],
    "filter_uptime": [
      {"name": "不限", "value": ""},
      {"name": "三日内", "value": "1"},
      {"name": "七日内", "value": "2"},
      {"name": "半月内", "value": "3"},
      {"name": "一月内", "value": "4"}
    ]
  };

  @override
  void onInit() {
    paras = {
      "filter_word": "",
      "count": "20",
      "tags": "[]",
      "page": 0,
      "is_paid": "",
      "category_index": "0",
      "key": sKey,
      "filter_uptime": "",
      "up_status": "",
      "order": ""
    };
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void setSearchParam(paras) {
    this.paras = paras;
    update();
  }

  void resetSearchParam() {
    this.paras['key'] = sKey;
    this.paras['order'] = "";
    this.paras['filter_word'] = "";
    this.paras['up_status'] = "";
    this.paras['is_paid'] = "";
    this.paras['filter_uptime'] = "";
    update();
  }

  void fetchDatas() async {
    var res = await API.searchBooks(paras);
    if (bookList == null) bookList = [];
    List.from(res).forEach((ele) {
      Book book = bookFromJson(json.encode(ele));
      bookList.add(book);
    });
    update();
    refreshController.loadComplete();
    refreshController.refreshCompleted();
  }

  void reSearch() {
    bookList = null;
    update();
    this.fetchDatas();
  }

  void refreshPage() {
    paras['page'] = 0;
    paras['key'] = sKey;
    bookList = [];
    update();
    fetchDatas();
  }

  void nextPage() {
    paras['page']++;
    fetchDatas();
  }
}
