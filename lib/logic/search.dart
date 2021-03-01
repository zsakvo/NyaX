import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class SearchLogic extends GetxController {
  GetStorage box;
  List<String> history = [];
  TextEditingController searchController = TextEditingController();
  bool showClearIcon = false;
  String sKey;

  SearchLogic({this.sKey});

  @override
  void onInit() {
    this.initController();
    this.initHistory();
    super.onInit();
  }

  initController() {
    if (this.sKey != null) searchController.text = this.sKey;
    searchController.addListener(() {
      showClearIcon = searchController.text.isNotEmpty;
      update();
    });
  }

  initHistory() {
    GetStorage.init("search").then((_) {
      box = GetStorage("search");
      history = List.from(box.read("history"));
      update();
    });
  }

  void push(String str) {
    history.insert(0, str);
    box.write("history", history);
    update();
  }

  void clean() {
    box.remove("history");
    history = [];
    update();
  }
}
