import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/module.dart';
import 'package:nyax/state/explore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../http/api.dart';

class ExploreLogic extends GetxController {
  final state = ExploreState();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final List tabs = [
    {"name": "排行", "value": "rank"},
    {"name": "折扣", "value": "discount"},
    {"name": "免费", "value": "free"},
    {"name": "书单", "value": "list"}
  ];

  void fetchDatas() async {
    var res = await API.getIndexList(200);
    state.tabsList.addAll(tabs);
    List.from(res).forEach((ele) {
      Module module = moduleFromJson(json.encode(ele));
      String title = module.moduleTitle;
      List<Book> list = [];
      if (module.moduleType == "1") {
        if (module.picBookList != null) {
          module.picBookList.forEach((ele) {
            list.add(bookFromJson(json.encode(ele)));
          });
          state.modulesList.add({"title": title, "list": list});
        }
      } else if (module.moduleType == "8") {
        module.bossModule.desBookList.forEach((ele) {
          list.add(bookFromJson(json.encode(ele)));
        });
        state.modulesList.add({"title": title, "list": list});
      } else if (module.moduleType == "9") {
        module.editorModule.desBookList.forEach((ele) {
          list.add(bookFromJson(json.encode(ele)));
        });
        state.modulesList.add({"title": title, "list": list});
      }
    });
    refreshController.refreshCompleted();
    refreshController.loadNoData();
  }

  void refresh() {
    state.modulesList([]);
    state.tabsList([]);
    this.fetchDatas();
  }
}
