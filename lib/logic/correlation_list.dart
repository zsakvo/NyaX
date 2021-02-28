import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book_correlation.dart';
import 'package:nyax/http/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CorrelationListLogic extends GetxController {
  int listType = 1;
  List<BookCorrelation> correlationList;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  dynamic paras = {
    "count": 20,
    "page": 0,
    "type": "1",
  };

  String get getListName {
    String name = "本月最热";
    switch (this.listType) {
      case 1:
        name = "本月最热";
        break;
      case 2:
        name = "最近更新";
        break;
      case 3:
        name = "最多收藏";
        break;
    }
    return name;
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void fetchDatas() async {
    var res = await API.getCorrelations(paras);
    if (correlationList == null) correlationList = [];
    List.from(res).forEach((ele) {
      correlationList.add(bookCorrelationFromJson(json.encode(ele)));
    });
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    update();
  }

  void setListType(type) {
    correlationList = null;
    update();
    this.listType = type;
    this.paras['type'] = type;
    this.paras['page'] = 0;
    this.fetchDatas();
  }

  refreshPage() {
    correlationList = [];
    update();
    paras["page"] = 0;
    this.fetchDatas();
  }

  nextPage() {
    paras["page"]++;
    this.fetchDatas();
  }
}
