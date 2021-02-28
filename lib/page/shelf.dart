import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/logic/shelf.dart';
import 'package:nyax/state/shelf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Shelf extends StatefulWidget {
  Shelf({Key key}) : super(key: key);

  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  ShelfLogic logic = Get.put(ShelfLogic());
  ShelfState state = Get.find<ShelfLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          "我的书架",
          style: TextStyle(
              color: HexColor('#313131'),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: logic.refreshController,
            onRefresh: () => logic.refresh(),
            onLoading: () => logic.nextPage(),
            child: ListView.builder(
              itemCount: state.bookList.length,
              itemExtent: 106,
              itemBuilder: (context, index) {
                return _buildBookRow(state.bookList[index]);
              },
            ));
      }),
    );
  }

  Widget _buildBookRow(Book book) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: book.cover,
                width: 70,
                height: 98,
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                  height: 90,
                  width: Get.width - 118,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.bookName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#313131").withOpacity(0.8),
                            height: 1.4),
                      ),
                      Text(book.authorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: HexColor("#313131").withOpacity(0.7),
                              height: 1.4)),
                      Text(book.lastChapterInfo.chapterTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: HexColor("#313131").withOpacity(0.7),
                              height: 1.4))
                    ],
                  ))
            ],
          )),
      onTap: () {
        // LogUtil.v(book.toJson());
        // CwmRouter.push("cwm://BookContentPage", book);
      },
      onLongPress: () => _showBottomModal(book),
    );
  }

  _showBottomModal(Book book) {
    TextStyle _textStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: HexColor("#313131"));
    Get.bottomSheet(
        Container(
          color: Colors.grey[50],
          padding: EdgeInsets.only(top: 2, bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  book.bookName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                  dense: true,
                  leading: Container(
                    width: 20,
                    child:
                        Image.asset("assets/image/ic_bottom_modal_detail.png"),
                  ),
                  title: Align(
                      alignment: Alignment(-1.05, 0),
                      child: Text(
                        '书籍详情',
                        style: _textStyle,
                      )),
                  onTap: () {
                    Navigator.of(context).pop();
                    // CwmRouter.push("cwm://BookDetailPage", book.bookId);
                  }),
              ListTile(
                dense: true,
                leading: Container(
                  width: 20,
                  child:
                      Image.asset("assets/image/ic_bottom_modal_download.png"),
                ),
                title: Align(
                    alignment: Alignment(-1.05, 0),
                    child: Text(
                      '缓存全本',
                      style: _textStyle,
                    )),
                onTap: () => Navigator.of(context).pop('Video'),
              ), //Navigator.of(context).pop('Music')),
              ListTile(
                dense: true,
                leading: Container(
                  width: 20,
                  child: Image.asset("assets/image/ic_bottom_modal_praise.png"),
                ),
                title: Align(
                    alignment: Alignment(-1.05, 0),
                    child: Text(
                      '投票打赏',
                      style: _textStyle,
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                  // _showRewardDialog(book);
                },
              ),
              ListTile(
                dense: true,
                leading: Container(
                  width: 20,
                  child: Image.asset("assets/image/ic_bottom_modal_clean.png"),
                ),
                title: Align(
                    alignment: Alignment(-1.05, 0),
                    child: Text(
                      '删除书籍',
                      style: _textStyle,
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                  _showDeleteDialog(book);
                },
              ),
            ],
          ),
        ),
        enterBottomSheetDuration: Duration(milliseconds: 200));
  }

  _showDeleteDialog(Book book) {
    if (GetPlatform.isAndroid) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
    }
    Get.dialog(
      Dialog(
        child: Container(
          color: Colors.grey[50],
          width: Get.width * 0.8,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "移除书籍",
                style: TextStyle(
                    color: HexColor("#313131"),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "此操作将从您的书架中移除本书（不止本地）且无法恢复，是否继续？",
                style: TextStyle(
                    fontSize: 14,
                    color: HexColor("#313131").withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    height: 1.5),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ((Get.width - 40) * 0.8 - 24) / 2,
                    height: 36,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                HexColor("#313131").withOpacity(0.05)),
                            overlayColor: MaterialStateProperty.all(
                                HexColor("#313131").withOpacity(0.07))),
                        onPressed: () {
                          // OneContext().popDialog();
                        },
                        child: Text(
                          "取消",
                          style: TextStyle(
                              color: HexColor("#313131").withOpacity(0.7)),
                        )),
                  ),
                  Container(
                    width: ((Get.width - 40) * 0.8 - 24) / 2,
                    height: 36,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                HexColor("#1e88e5").withOpacity(1.0)),
                            overlayColor: MaterialStateProperty.all(
                                Colors.blue.withOpacity(1.0))),
                        onPressed: () {
                          // OneContext().popDialog();
                          // _currentShelfModel.deleteBook(book);
                        },
                        child: Text(
                          "确认",
                          style: TextStyle(color: HexColor("#ffffff")),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
