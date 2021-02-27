import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/prop_info.dart';
import 'package:nyax/bean/reader_info.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/state/user.dart';

class UserLogic extends GetxController {
  final state = UserState();

  final List lvList = [
    '书中过客',
    "读书御宅",
    "炼文立传",
    "小有名气",
    "略有小成",
    "出类拔萃",
    "出神入化",
    "无双隐士",
    "世外高人",
    "三界圣贤",
    "盖世英豪",
    "笑傲江湖",
    "荣耀元老",
    "精神领袖",
    "土豪宗师"
  ];

  void fetchDatas() async {
    var res = await API.getMyInfo();
    ReaderInfo readerInfo =
        readerInfoFromJson(json.encode(res['data']['reader_info']));
    PropInfo propInfo = propInfoFromJson(json.encode(res['data']['prop_info']));
    String trackAmount = res['data']['track_amount'].toString();
    String followingAmount = res['data']['following_amount'].toString();
    String followedAmount = res['data']['followed_amount'].toString();
    state.readerInfo(readerInfo);
    state.propInfo(propInfo);
    state.trackAmount.value = trackAmount;
    state.followingAmount.value = followingAmount;
    state.followedAmount.value = followedAmount;
    state.lvInfo.value = lvList[int.parse(readerInfo.expLv) - 1];
  }
}
