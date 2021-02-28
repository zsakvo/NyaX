import 'package:get/state_manager.dart';
import 'package:nyax/bean/book.dart';

class RankState {
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

  RxString currentRankName;
  RxList<Book> bookList;
  RankState() {
    currentRankName = "点击榜".obs;
    bookList = [].obs;
  }
}
