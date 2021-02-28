import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/module.dart';
import 'package:nyax/http/api.dart';

class FreeLogic extends GetxController {
  List<dynamic> tabsList;
  List<dynamic> modulesList;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void fetchDatas() async {
    var res = await API.getIndexList(2);
    tabsList = [];
    modulesList = [];
    List.from(res).forEach((ele) {
      Module module = moduleFromJson(json.encode(ele));
      String title = module.moduleTitle;
      List<Book> bList = [];
      if (module.moduleType == "1" || module.moduleType == "3") {
        module.picBookList.forEach((ele) {
          bList.add(bookFromJson(json.encode(ele)));
        });
        modulesList.add({"title": title, "list": bList});
      } else if (module.moduleType == "4") {
        module.specialModuleList.forEach((sm) {
          tabsList.add(sm);
        });
      }
    });
    update();
  }
}
