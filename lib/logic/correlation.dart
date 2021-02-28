import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/http/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CorrelationLogic extends GetxController {
  dynamic paras = {
    "list_id": "4051",
    "count": 20,
    "page": 0,
  };
  List<Book> bookList;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void setId(id) {
    this.paras['list_id'] = id;
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  fetchDatas() async {
    var res = await API.getBookListDetail(paras);
    if (bookList == null) bookList = [];
    List.from(res['book_list']).forEach((ele) {
      bookList.add(bookFromJson(json.encode(ele)));
    });
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    update();
  }

  refreshPage() {
    bookList = [];
    update();
    paras["page"] = 0;
    this.fetchDatas();
  }

  nextPage() {
    paras["page"]++;
    this.fetchDatas();
  }
}
