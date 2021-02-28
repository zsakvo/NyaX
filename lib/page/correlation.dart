import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/book_correlation.dart';
import 'package:nyax/logic/correlation.dart';
import 'package:nyax/widget/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CorrelationPage extends StatelessWidget {
  CorrelationPage({Key key}) : super(key: key);
  final CorrelationLogic logic = Get.put(CorrelationLogic());

  @override
  Widget build(BuildContext context) {
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
          "书单详情",
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
              // _buildRanks();
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
      body: GetBuilder<CorrelationLogic>(
        builder: (logic) {
          if (logic.bookList == null) {
            return Loading();
          } else {
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: logic.refreshController,
                onRefresh: () => logic.refreshPage(),
                onLoading: () => logic.nextPage(),
                child: ListView.builder(
                  itemCount: logic.bookList.length,
                  // itemExtent: 120,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildListHeader();
                    } else {
                      return _buildBookInkWell(logic.bookList[index - 1]);
                    }
                  },
                ));
          }
        },
      ),
    );
  }

  Widget _buildListHeader() {
    BookCorrelation booklist = Get.arguments;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: HexColor("#313131").withOpacity(0.6), width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booklist.listName,
            style: TextStyle(
                color: HexColor("#313131").withOpacity(0.9),
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: booklist.readerInfo.avatarThumbUrl,
                    width: 48,
                    height: 48,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: booklist.readerInfo.readerName,
                      style: TextStyle(
                          color: HexColor("#313131"),
                          fontSize: 13,
                          height: 1.3)),
                  TextSpan(
                    text: "\n",
                    style: TextStyle(fontSize: 8, height: 1),
                  ),
                  TextSpan(
                      text: booklist.favorNum + "收藏",
                      style: TextStyle(
                          color: HexColor("#313131").withOpacity(0.6),
                          fontSize: 12,
                          height: 1.3))
                ]))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              booklist.listIntroduce,
              style: TextStyle(
                  color: HexColor("#313131").withOpacity(0.8),
                  fontSize: 13,
                  height: 1.6),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBookInkWell(Book book) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: HexColor("#313131").withOpacity(0.4),
                      width: 0.1))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                      imageUrl: book.cover, width: 40, height: 56),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: Get.width - 118,
                    height: 56,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.bookName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor("#333333").withOpacity(0.9),
                              fontSize: 14,
                              height: 1.4),
                        ),
                        Text(
                          "\n \n",
                          style: TextStyle(height: 1.0, fontSize: 1.8),
                        ),
                        Text(
                          book.authorName,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: HexColor("#717171"),
                              fontSize: 12,
                              height: 1.4),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 8),
                        //   child: Text(
                        //     book.bookComment,
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w300,
                        //         color: HexColor("#717171"),
                        //         fontSize: 13,
                        //         height: 1.3),
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
              book.bookComment.trim().isEmpty
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ExpandableText(
                        book.bookComment.trim(),
                        expandText: '展开',
                        style: TextStyle(
                            color: HexColor("#313131").withOpacity(0.6),
                            fontSize: 12),
                        collapseText: '\n收起',
                        maxLines: 3,
                        linkEllipsis: false,
                        linkColor: Colors.blue,
                        linkStyle: TextStyle(fontSize: 12),
                      ),
                    )
            ],
          )),
      onTap: () {
        Get.toNamed("/bookDetail", arguments: book.bookId);
        // CwmRouter.push("cwm://BookDetailPage", book.bookId);
      },
    );
  }
}
