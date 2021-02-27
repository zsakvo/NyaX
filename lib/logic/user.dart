import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/reader_info.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/state/user.dart';

class UserLogic extends GetxController {
  final state = UserState();

  void fetchDatas() async {
    var res = await API.getMyInfo();
    ReaderInfo readerInfo =
        readerInfoFromJson(json.encode(res['data']['reader_info']));
    state.readerInfo(readerInfo);
  }
}
