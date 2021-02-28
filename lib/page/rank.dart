import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/rank.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:nyax/widget/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankPage extends StatelessWidget {
  final RankLogic logic = Get.put(RankLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankLogic>(
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
              logic.currentRankName,
              style: TextStyle(
                  fontSize: 16,
                  color: HexColor("#313131").withOpacity(0.9),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                radius: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                  child: Image.asset("assets/image/ic_toolbar_filter.png"),
                ),
                onTap: () {
                  _buildRanks();
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
          body: Builder(
            builder: (context) {
              return logic.bookList == null
                  ? Loading()
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: logic.refreshController,
                      onRefresh: logic.refreshPage,
                      onLoading: logic.nextPage,
                      child: logic.bookList.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: logic.bookList.length,
                              itemExtent: 120,
                              itemBuilder: (context, index) {
                                return BookRow(logic.bookList[index]);
                              },
                            ));
            },
          ),
        );
      },
    );
  }

  _buildRanks() {
    Get.bottomSheet(GetBuilder<RankLogic>(
      builder: (logic) {
        return Container(
          color: Colors.grey[50],
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  child: Row(
                    children: [
                      Text(
                        "排行榜",
                        style: TextStyle(
                            color: HexColor("#313131").withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                      TextButton(
                          onPressed: () {
                            logic.refreshPage();
                            Get.back();
                          },
                          child: Text(
                            "确定",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          style: ButtonStyle(
                              // minimumSize:
                              //     MaterialStateProperty.all(Size(64, 20)),
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
                          "榜单",
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
                          alignment: WrapAlignment.start,
                          children: logic.menuList.map<Widget>((r) {
                            return ChoiceChip(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              elevation: 0,
                              pressElevation: 0,
                              selectedColor:
                                  HexColor("#2196f3").withOpacity(0.2),
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  HexColor("#e0e0e0").withOpacity(.6),
                              labelStyle: TextStyle(fontSize: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              label: Text(
                                r['name'],
                                style: TextStyle(
                                    color:
                                        logic.searchParas["order"] == r["para"]
                                            ? HexColor("#42a5f5")
                                            : HexColor("#313131")),
                              ),
                              selected: logic.searchParas["order"] == r["para"],
                              onSelected: (_) {
                                logic.setSearchParaOrder(r["para"], r["name"]);
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "时间",
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
                          children: List.from(
                                  logic.rankTimes[logic.searchParas['order']])
                              .map<Widget>((t) {
                            return ChoiceChip(
                              elevation: 0,
                              pressElevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              selectedColor:
                                  HexColor("#2196f3").withOpacity(0.2),
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  HexColor("#e0e0e0").withOpacity(.6),
                              labelStyle: TextStyle(fontSize: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              label: Text(
                                t["name"],
                                style: TextStyle(
                                    color: logic.searchParas['time_type'] ==
                                            t["value"]
                                        ? HexColor("#42a5f5")
                                        : HexColor("#313131")),
                              ),
                              selected:
                                  logic.searchParas['time_type'] == t["value"],
                              onSelected: (_) {
                                logic.setSearchParaTime(t["value"]);
                              },
                            );
                          }).toList(),
                        ),
                      ]))
            ],
          ),
        );
      },
    ));
  }
}
