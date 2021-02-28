import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/explore.dart';
import 'package:nyax/state/explore.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final ExploreLogic logic = Get.put(ExploreLogic());
  final ExploreState state = Get.find<ExploreLogic>().state;

  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    logic.fetchDatas();
    refreshController = logic.refreshController;
  }

  void _onLoad() async {
    logic.refresh();
  }

  @override
  Widget build(BuildContext context) {
    List tabs = ["排行", "折扣", "免费", "书单"];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          title: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(
                    bottom: BorderSide(
                      color: HexColor("#bdc3c7"),
                      width: 0.1,
                    ),
                  )),
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        //背景
                        color: HexColor("#f2f2f2"),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        //设置四周边框
                        border: Border.all(
                          width: 1,
                          color: HexColor("#f2f2f2"),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          ColorFiltered(
                            child: Image.asset(
                              "assets/image/ic_search_bar_prefix.png",
                              width: 16,
                            ),
                            colorFilter: ColorFilter.mode(
                                HexColor('#919191'), BlendMode.srcIn),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "搜索书籍或作者",
                            style: TextStyle(
                                color: HexColor("#919191"), fontSize: 13),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      // CwmRouter.pushNoParams("cwm://SearchPage");
                    },
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                  )),
                ],
              )),
        ),
        body: Obx(() {
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: refreshController,
              onRefresh: () => _onLoad(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  state.tabsList.length == 0
                      ? SizedBox.shrink()
                      : Container(
                          width: Get.width,
                          height: 42,
                          decoration: BoxDecoration(
                              // color: Colors.grey[50],
                              border: Border(
                            bottom: BorderSide(
                              color: HexColor("#bdc3c7"),
                              width: 0.1,
                            ),
                            top: BorderSide(
                              color: HexColor("#bdc3c7"),
                              width: 0.1,
                            ),
                          )),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: (Get.width - tabs.length) / 4,
                                    child: InkWell(
                                      child: Text(
                                        state.tabsList[index]['name'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#495057")),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    switch (state.tabsList[index]['value']) {
                                      case 'rank':
                                        // CwmRouter.pushNoParams("cwm://RankPage");
                                        break;
                                      case 'list':
                                        // CwmRouter.pushNoParams(
                                        //     "cwm://BookCorrelationListsPage");
                                        break;
                                      case 'free':
                                        //   CwmRouter.pushNoParams("cwm://BookFreePage");
                                        break;
                                      case 'discount':
                                        // CwmRouter.pushNoParams("cwm://BookDiscountPgae");
                                        break;
                                    }
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  width: 1,
                                  child: VerticalDivider(
                                    color: HexColor("#313131").withOpacity(0.6),
                                    thickness: 0.1,
                                  ),
                                );
                              },
                              itemCount: state.tabsList.length),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  ...state.modulesList
                      .map((module) => _buildModule(module))
                      .toList()
                ],
              ));
        }));
  }

  Widget _buildModule(module) {
    List books = List.from(module["list"]).take(3).toList();
    return Container(
      child: Column(
        children: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    module["title"],
                    style: TextStyle(
                        color: HexColor("#313131").withOpacity(0.7),
                        fontSize: 14),
                  ),
                  Container(
                    width: 20,
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    child: ColorFiltered(
                      child: Image.asset("assets/image/ic_title_right.png"),
                      colorFilter: ColorFilter.mode(
                          HexColor('#616b75'), BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // CwmRouter.push("cwm://ExtraBookListPage", module);
            },
            // hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            // radius: 0.0,
          ),
          ...books.map((book) {
            return BookRow(book);
          }).toList()
        ],
      ),
    );
  }
}
