import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/search_list.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:nyax/widget/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchListPage extends StatelessWidget {
  SearchListPage({Key key}) : super(key: key);
  final SearchListLogic logic = Get.put(SearchListLogic(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchListLogic>(
      builder: (logic) {
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              centerTitle: false,
              backgroundColor: Colors.grey[50],
              elevation: 0,
              leading: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                radius: 0.0,
                child: Container(
                  width: 56,
                  height: 56,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Image.asset("assets/image/ic_toolbar_left.png"),
                ),
                onTap: () {
                  print("on tap toolbar menu");
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "搜索 “${logic.paras["key"]}”",
                style: TextStyle(
                    fontSize: 16,
                    color: HexColor("#313131"),
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  radius: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                    child: Image.asset("assets/image/ic_toolbar_search2.png"),
                  ),
                  onTap: () {
                    Get.offAndToNamed("/search", arguments: logic.paras["key"]);
                    // CwmRouter.pushAndRemove("cwm://SearchPage", Get.arguments("sKey"));
                  },
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  radius: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                    child: Image.asset("assets/image/ic_toolbar_filter.png"),
                  ),
                  onTap: () {
                    _buildFilter();
                  },
                ),
                SizedBox(
                  width: 6,
                )
              ],
              bottom: PreferredSize(
                  child: Container(
                    color: HexColor("#bdc3c7"),
                    height: 0.1,
                  ),
                  preferredSize: Size.fromHeight(0.1)),
            ),
            body: logic.bookList == null
                ? Loading()
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: logic.refreshController,
                    onRefresh: () => logic.refreshPage(),
                    onLoading: () => logic.nextPage(),
                    child: logic.bookList.length != 0
                        ? ListView.builder(
                            itemCount: logic.bookList.length,
                            itemExtent: 120,
                            itemBuilder: (context, index) {
                              return BookRow(logic.bookList[index]);
                            },
                          )
                        : SizedBox.shrink()));
      },
    );
  }

  _buildFilter() {
    Get.bottomSheet(GetBuilder<SearchListLogic>(
      builder: (logic) {
        return Container(
          color: Colors.grey[50],
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  // decoration: BoxDecoration(
                  //     border: Border(
                  //         bottom: BorderSide(
                  //             color: HexColor("#424242"), width: 0.1))),
                  child: Row(
                    children: [
                      Text(
                        "筛选",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                      TextButton(
                        onPressed: () {
                          logic.resetSearchParam();
                        },
                        child: Text(
                          "重置",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.back();
                            logic.reSearch();
                          },
                          child: Text(
                            "确定",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.withOpacity(0.9)))),
                    ],
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "排序",
                      style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#313131"),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: List.from(logic.filterParams["order"])
                          .map<Widget>((order) {
                        return ChoiceChip(
                          elevation: 0,
                          pressElevation: 0,
                          selectedColor: HexColor("#2196f3").withOpacity(0.2),
                          shadowColor: Colors.transparent,
                          backgroundColor: HexColor("#e0e0e0").withOpacity(.6),
                          labelStyle: TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          label: Text(
                            order['name'],
                            style: TextStyle(
                                color: logic.paras['order'] == order["value"]
                                    ? HexColor("#42a5f5")
                                    : HexColor("#313131")),
                          ),
                          selected: logic.paras['order'] == order["value"],
                          onSelected: (v) {
                            logic.paras['order'] = order["value"];
                            logic.setSearchParam(logic.paras);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "字数",
                      style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#313131"),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: List.from(logic.filterParams["filter_word"])
                          .map<Widget>((word) {
                        return ChoiceChip(
                          elevation: 0,
                          pressElevation: 0,
                          selectedColor: HexColor("#2196f3").withOpacity(0.2),
                          shadowColor: Colors.transparent,
                          backgroundColor: HexColor("#e0e0e0").withOpacity(.6),
                          labelStyle: TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          label: Text(
                            word["name"],
                            style: TextStyle(
                                color:
                                    logic.paras['filter_word'] == word["value"]
                                        ? HexColor("#42a5f5")
                                        : HexColor("#313131")),
                          ),
                          selected: logic.paras['filter_word'] == word["value"],
                          onSelected: (v) {
                            logic.paras['filter_word'] = word["value"];
                            logic.setSearchParam(logic.paras);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "进度",
                      style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#313131"),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: List.from(logic.filterParams["up_status"])
                          .map<Widget>((status) {
                        return ChoiceChip(
                          elevation: 0,
                          pressElevation: 0,
                          selectedColor: HexColor("#2196f3").withOpacity(0.2),
                          shadowColor: Colors.transparent,
                          backgroundColor: HexColor("#e0e0e0").withOpacity(.6),
                          labelStyle: TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          label: Text(
                            status["name"],
                            style: TextStyle(
                                color:
                                    logic.paras['up_status'] == status["value"]
                                        ? HexColor("#42a5f5")
                                        : HexColor("#313131")),
                          ),
                          selected: logic.paras['up_status'] == status["value"],
                          onSelected: (v) {
                            logic.paras['up_status'] = status["value"];
                            logic.setSearchParam(logic.paras);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "状态",
                      style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#313131"),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: List.from(logic.filterParams["is_paid"])
                          .map<Widget>((paid) {
                        return ChoiceChip(
                          elevation: 0,
                          pressElevation: 0,
                          selectedColor: HexColor("#2196f3").withOpacity(0.2),
                          shadowColor: Colors.transparent,
                          backgroundColor: HexColor("#e0e0e0").withOpacity(.6),
                          labelStyle: TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          label: Text(
                            paid["name"],
                            style: TextStyle(
                                color: logic.paras['is_paid'] == paid["value"]
                                    ? HexColor("#42a5f5")
                                    : HexColor("#313131")),
                          ),
                          selected: logic.paras['is_paid'] == paid["value"],
                          onSelected: (v) {
                            logic.paras['is_paid'] = paid["value"];
                            logic.setSearchParam(logic.paras);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "更新时间",
                      style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#313131"),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      children: List.from(logic.filterParams["filter_uptime"])
                          .map<Widget>((uptime) {
                        return ChoiceChip(
                          elevation: 0,
                          pressElevation: 0,
                          selectedColor: HexColor("#2196f3").withOpacity(0.2),
                          shadowColor: Colors.transparent,
                          backgroundColor: HexColor("#e0e0e0").withOpacity(.6),
                          labelStyle: TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          label: Text(
                            uptime["name"],
                            style: TextStyle(
                                color: logic.paras["filter_uptime"] ==
                                        uptime["value"]
                                    ? HexColor("#42a5f5")
                                    : HexColor("#313131")),
                          ),
                          selected:
                              logic.paras["filter_uptime"] == uptime["value"],
                          onSelected: (v) {
                            logic.paras["filter_uptime"] = uptime["value"];
                            logic.setSearchParam(logic.paras);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              )
            ],
          ),
        );
      },
    ), isScrollControlled: true);
  }
}
