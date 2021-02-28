import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book_correlation.dart';
import 'package:nyax/logic/correlation.dart';
import 'package:nyax/widget/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CorrelationPage extends StatelessWidget {
  CorrelationPage({Key key}) : super(key: key);
  final CorrelationLogic logic = Get.put(CorrelationLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CorrelationLogic>(
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
              logic.getListName,
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
                  _switchTypes();
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
              if (logic.correlationList == null) {
                return Loading();
              } else {
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: logic.refreshController,
                    onRefresh: () => logic.refreshPage(),
                    onLoading: () => logic.nextPage(),
                    child: logic.correlationList.length == 0
                        ? SizedBox.shrink()
                        : ListView.builder(
                            itemCount: logic.correlationList.length,
                            itemExtent: 106,
                            itemBuilder: (context, index) {
                              return _buildListInkWell(
                                  logic.correlationList[index]);
                            },
                          ));
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildListInkWell(BookCorrelation list) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Positioned(
                    child: CachedNetworkImage(
                      imageUrl: list.bookInfoList[1].cover,
                      height: 64,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                    left: 0,
                  ),
                  Positioned(
                    child: CachedNetworkImage(
                      imageUrl: list.bookInfoList[2].cover,
                      height: 64,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                    right: 0,
                  ),
                  Positioned(
                    child: Material(
                      elevation: 4,
                      child: CachedNetworkImage(
                        imageUrl: list.bookInfoList[0].cover,
                        height: 76,
                        width: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    left: 12,
                    right: 12,
                    top: 2,
                    bottom: 2,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl: demo.bookInfoList[2].cover,
                  // )
                ],
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  list.listName,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#313131")),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "${list.readerInfo.readerName} · ${list.bookNum}部 · ${list.favorNum}收藏",
                  style: TextStyle(
                      fontSize: 12,
                      color: HexColor("#313131").withOpacity(0.6)),
                )
              ],
            ))
          ],
        ),
      ),
      onTap: () {
        // CwmRouter.push("cwm://BookCorrelationListDetailPage", list);
      },
    );
  }

  _switchTypes() {
    var list = [
      {'name': '本月最热', 'value': 1},
      {'name': '最近更新', 'value': 2},
      {'name': '最多收藏', 'value': 3}
    ];
    TextStyle _textStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#313131"));
    TextStyle _currentTextStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blue);
    Get.bottomSheet(GetBuilder<CorrelationLogic>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: 4, bottom: 12),
          color: Colors.grey[50],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  '切换',
                  style: TextStyle(
                      fontSize: 16,
                      color: HexColor("#313131").withOpacity(0.9),
                      fontWeight: FontWeight.bold),
                ),
              ),
              ...list.map((_list) {
                return ListTile(
                    title: Text(
                      "${_list['name']}",
                      style: _list['value'] == logic.listType
                          ? _currentTextStyle
                          : _textStyle,
                    ),
                    onTap: () {
                      logic.setListType(_list['value']);
                      Get.back();
                    });
              }).toList()
            ],
          ),
        );
      },
    ));
  }
}
