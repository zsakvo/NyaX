import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/module.dart';
import 'package:nyax/http/API.dart';

class DiscountLogic extends GetxController {
  List<dynamic> list;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void fetchDatas() async {
    var res = await API.getDiscountBook();
    list = [];
    List.from(res).forEach((ele) {
      Module module = moduleFromJson(json.encode(ele));
      String title = module.moduleTitle;
      List<Book> bList = [];
      if (module.moduleType == "1") {
        module.picBookList.forEach((ele) {
          bList.add(bookFromJson(json.encode(ele)));
        });
        list.add({"title": title, "list": bList});
      } else if (module.moduleType == "8") {
        module.bossModule.desBookList.forEach((ele) {
          bList.add(bookFromJson(json.encode(ele)));
        });
        list.add({"title": title, "list": bList});
      }
    });
    update();
  }
}
