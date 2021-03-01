import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/search.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key}) : super(key: key);
  final SearchLogic logic = Get.put(SearchLogic(sKey: Get.arguments));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(
      builder: (logic) {
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.grey[50],
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                  child: Container(
                    color: HexColor("#bdc3c7"),
                    height: 0.1,
                  ),
                  preferredSize: Size.fromHeight(0.1)),
              title: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              style: BorderStyle.solid,
                              color: HexColor("#bdc3c7"),
                              width: 0.3))),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                  child: Row(
                    children: [
                      InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        radius: 0.0,
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child:
                              Image.asset("assets/image/ic_toolbar_left.png"),
                        ),
                        onTap: () {
                          print("on tap toolbar menu");
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                          width: context.width - 120,
                          child: TextField(
                            controller: logic.searchController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "搜索书名或作者",
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.only(
                              //     top: logic.showClearIcon ? 20 : 6,
                              //     bottom: logic.showClearIcon ? 0 : 8),
                              isDense: true,
                              // suffixIconConstraints:
                              //     BoxConstraints(maxHeight: 32, maxWidth: 16),
                              // suffixIcon: logic.showClearIcon
                              //     ? InkWell(
                              //         child: Container(
                              //           width: 56,
                              //           height: 56,
                              //           padding: EdgeInsets.symmetric(
                              //               vertical: 16, horizontal: 16),
                              //           child: Image.asset(
                              //               "assets/image/ic_toolbar_close.png"),
                              //         ),
                              //         hoverColor: Colors.transparent,
                              //         highlightColor: Colors.transparent,
                              //         radius: 0.0,
                              //         onTap: () {
                              //           print("clear");
                              //           logic.searchController.clear();
                              //         },
                              //       )
                              //     : null
                            ),
                            onSubmitted: (value) {
                              value = value.trim();
                              if (value.isEmpty) {
                                return;
                              }
                              logic.push(value);
                              Get.offAndToNamed("/searchList",
                                  arguments: value);
                              // CwmRouter.pushAndRemove(
                              //     "cwm://SearchResultPage", value);
                            },
                          )),
                      InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        radius: 0.0,
                        child: Container(
                          width: 56,
                          height: 56,
                          padding: EdgeInsets.all(18),
                          child: Image.asset(logic.showClearIcon
                              ? "assets/image/ic_toolbar_close.png"
                              : "assets/image/ic_toolbar_clear.png"),
                        ),
                        onTap: () {
                          logic.showClearIcon
                              ? logic.searchController.clear()
                              : logic.clean();
                        },
                      )
                    ],
                  )),
            ),
            body: ListView(
                shrinkWrap: true,
                children: logic.history.map((history) {
                  return InkWell(
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                      leading: Container(
                        height: 20,
                        child:
                            Image.asset("assets/image/ic_toolbar_search2.png"),
                      ),
                      title: Text(
                        history,
                        style: TextStyle(color: HexColor("#333333")),
                      ),
                    ),
                    onTap: () {
                      Get.offAndToNamed("/searchList", arguments: history);
                      // CwmRouter.pushAndRemove(
                      //     "cwm://SearchResultPage", history);
                    },
                  );
                }).toList()));
      },
    );
  }
}
