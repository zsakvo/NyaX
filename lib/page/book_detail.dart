import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/book_detail.dart';
import 'package:nyax/state/book_detail.dart';

class BookDetailPage extends StatefulWidget {
  BookDetailPage({Key key}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookDetailLogic logic = Get.put(BookDetailLogic());
  final BookDetailState state = Get.find<BookDetailLogic>().state;
  String bid;
  String title = '';
  @override
  void initState() {
    bid = Get.arguments;
    super.initState();
    logic.fetchDatas(bid);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!state.isReady.value) {
        return Container();
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Container(
            child: Text(
              title,
              style: TextStyle(color: HexColor('#222222'), fontSize: 16),
            ),
          ),
          centerTitle: false,
          brightness: Brightness.light,
          titleSpacing: 0,
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
          actions: [
            InkWell(
              child: Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: state.isInShelf.value
                    ? Image.asset("assets/image/ic_toolbar_clear.png")
                    : Image.asset("assets/image/ic_toolbar_add.png"),
              ),
              onTap: () {
                if (state.isInShelf.value) {
                  //已在书架，进行删除

                } else {
                  //未在书架，进行添加
                }
              },
            )
          ],
        ),
        body: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 42),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                            imageUrl: state.book.value.cover,
                            width: 70,
                            height: 98),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 90,
                          width: Get.width - 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                state.book.value.bookName,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: HexColor("313131").withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    height: 1.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                state.book.value.authorName,
                                style: TextStyle(
                                    color: HexColor("313131").withOpacity(0.7),
                                    fontSize: 14,
                                    height: 1.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${(int.parse(state.book.value.totalFavor))} 收藏 / ${(int.parse(state.book.value.totalClick) / 10000).toStringAsFixed(2)} 万点击",
                                style: TextStyle(
                                    color: HexColor("313131").withOpacity(0.7),
                                    fontSize: 12,
                                    height: 1.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "简介",
                          style: TextStyle(
                              color: HexColor("#313131").withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandableText(
                          state.book.value.description,
                          style: TextStyle(
                            color: HexColor("313131").withOpacity(0.7),
                          ),
                          expandText: '展开',
                          collapseText: '\n收起',
                          maxLines: 3,
                          linkColor: Colors.blue,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Container(
                      child: Wrap(
                          runSpacing: 8,
                          spacing: 16,
                          children:
                              state.book.value.tagList.take(5).map((_tag) {
                            return Text(
                              "#" + _tag.tagName,
                              style:
                                  TextStyle(color: _getTagColor(_tag.tagType)),
                            );
                          }).toList()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(
                        color: HexColor("#bdc3c7"),
                        thickness: 0.1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "连载",
                                style: TextStyle(
                                    color: HexColor("#313131").withOpacity(0.9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: "\t\t"),
                              TextSpan(
                                text:
                                    "共${state.book.value.chapterAmount}章 / ${(int.parse(state.book.value.totalWordCount) / 10000).toStringAsFixed(2)}万字",
                                style: TextStyle(
                                    color: HexColor("313131").withOpacity(0.7),
                                    fontSize: 12,
                                    height: 1.0),
                              ),
                            ])),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "1天前 · ${state.book.value.lastChapterInfo.chapterTitle}",
                                style: TextStyle(
                                    color: HexColor("#595959"), fontSize: 14),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                child: ColorFiltered(
                                  child: Image.asset(
                                      "assets/image/ic_title_right.png"),
                                  colorFilter: ColorFilter.mode(
                                      HexColor('#313131'), BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: HexColor("#bdc3c7"),
                        thickness: 0.1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "书单",
                                style: TextStyle(
                                    color: HexColor("#333333"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(text: "\t\t"),
                              TextSpan(
                                text: "共 ${state.bookCorrelationNum} 个",
                                style: TextStyle(
                                    color: HexColor("#717171"),
                                    fontSize: 12,
                                    height: 1.0),
                              ),
                            ])),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.bookCorrelationList.map(
                            (_bookList) {
                              return InkWell(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            "assets/image/ic_list_energy.png",
                                            width: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          _bookList.listName.trim(),
                                          style: TextStyle(
                                              color: HexColor("#333333"),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _bookList.listIntroduce,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: HexColor("#434343"),
                                          fontSize: 13,
                                          height: 1.5),
                                    )
                                  ],
                                ),
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                radius: 0.0,
                                onTap: () {
                                  // CwmRouter.push(
                                  //     "cwm://BookCorrelationListDetailPage",
                                  //     _bookList);
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print("点了 fab");
            },
            icon: Container(
              child: Image.asset(
                "assets/image/ic_fab_read.png",
                width: 20,
              ),
            ),
            label: Text(
              "阅读书籍",
              style: TextStyle(letterSpacing: 0.8),
            )),
      );
    });
  }

  Color _getTagColor(tagType) {
    Color _color = HexColor("#16a085");
    switch (tagType) {
      case "1":
        _color = HexColor("#16a085");
        break;
      case "2":
        _color = HexColor("#1e90ff");
        break;
      case "3":
        _color = HexColor("#ff6348");
        break;
    }
    return _color;
  }
}
