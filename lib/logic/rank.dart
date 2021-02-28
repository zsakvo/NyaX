import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../http/api.dart';

class RankLogic extends GetxController {
  String currentRankName = "点击榜";
  List<Book> bookList;
  dynamic searchParas = {
    "order": "no_vip_click",
    "time_type": "week",
    "count": 20,
    "page": 0,
    "category_index": 0,
  };
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List menuList = [
    {
      "para": "no_vip_click",
      "name": "点击",
      "value": [
        {"name": "周榜", "value": "week"},
        {"name": "月榜", "value": "month"}
      ]
    },
    {
      "para": "fans_value",
      "name": "畅销",
      "value": [
        {"name": "24时", "value": "week"},
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "yp",
      "name": "月票",
      "value": [
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "yp_new",
      "name": "新书",
      "value": [
        {"name": "月榜", "value": "month"}
      ]
    },
    {
      "para": "favor",
      "name": "收藏",
      "value": [
        {"name": "三日", "value": "week"},
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "recommend",
      "name": "推荐",
      "value": [
        {"name": "周榜", "value": "week"},
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "blade",
      "name": "刀片",
      "value": [
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "word_count",
      "name": "更新",
      "value": [
        {"name": "周榜", "value": "week"},
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "tsukkomi",
      "name": "吐槽",
      "value": [
        {"name": "周榜", "value": "week"},
        {"name": "月榜", "value": "month"},
        {"name": "总榜", "value": "total"}
      ]
    },
    {
      "para": "complet",
      "name": "完本",
      "value": [
        {"name": "月榜", "value": "month"}
      ]
    },
    {
      "para": "track_read",
      "name": "追读",
      "value": [
        {"name": "三日", "value": "week"}
      ]
    }
  ];

  dynamic rankTimes = {
    "no_vip_click": [
      {"name": "周榜", "value": "week"},
      {"name": "月榜", "value": "month"}
    ],
    "fans_value": [
      {"name": "24时", "value": "week"},
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "yp": [
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "yp_new": [
      {"name": "月榜", "value": "month"}
    ],
    "favor": [
      {"name": "三日", "value": "week"},
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "recommend": [
      {"name": "周榜", "value": "week"},
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "blade": [
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "word_count": [
      {"name": "周榜", "value": "week"},
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "tsukkomi": [
      {"name": "周榜", "value": "week"},
      {"name": "月榜", "value": "month"},
      {"name": "总榜", "value": "total"}
    ],
    "complet": [
      {"name": "月榜", "value": "month"}
    ],
    "track_read": [
      {"name": "三日", "value": "week"}
    ]
  };

  String rankNameTmp = "点击榜";

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void fetchDatas() async {
    print("rank");
    var res = await API.getRank(this.searchParas);
    if (bookList == null) bookList = [];
    List.from(res['book_list']).forEach((ele) {
      bookList.add(bookFromJson(json.encode(ele)));
    });
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    this.currentRankName = this.rankNameTmp;
    update();
  }

  void setSearchParaOrder(order, orderName) {
    this.searchParas["order"] = order;
    this.searchParas["time_type"] = this.rankTimes[order][0]["value"];
    this.rankNameTmp = orderName + "榜";
    update();
  }

  void setSearchParaTime(time) {
    this.searchParas["time_type"] = time;
    update();
  }

  void refreshPage({newPage: false}) {
    searchParas['page'] = 0;
    bookList = newPage ? null : [];
    update();
    this.fetchDatas();
  }

  void nextPage() {
    searchParas['page']++;
    this.fetchDatas();
  }
}
