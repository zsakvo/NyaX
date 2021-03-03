import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/util/decrypt.dart';
import 'package:text_composition/text_composition.dart';

import '../global.dart';
// import 'package:nyax/widget/text_composition.dart';

class ChapterLogic extends GetxController {
  final Book book;
  ChapterLogic(this.book);

  List divisionList = [];
  List chapterList = [];

  TextComposition tc;

  List<TextPage> pages = [];
  List<Widget> pageWs = [];
  PageController pageController = PageController();

  int currentChapterIndex = 0;
  int currentPageIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    await this.fetchDivisions();
    await fetchChapters();
    fetchContent();
  }

  pageListener() async {
    if (pageController.position.isScrollingNotifier.value) {
      //在滚动呀
    } else {
      ObjectKey key = pageWs[pageController.page.round()].key;
      if (key != null) {
        var keyMap = Map<String, int>.from(key.value);
        this.currentChapterIndex = keyMap['cid'];
      }
      if (pageController.page.round() > currentPageIndex) {
        //后翻页
        if (pageController.page.round() == pageWs.length - 1) {
          // await nextPage();
          fetchContent(index: this.currentChapterIndex + 1);
        }
        currentPageIndex = pageController.page.round();
      }
    }
  }

  fetchDivisions() async {
    var res = await API.getDivisionList(bid: book.bookId);
    divisionList = List.from(res);
  }

  fetchChapters() async {
    var res = await API.getChapterListByDivisionId(
        did: divisionList[0]['division_id']);
    chapterList.addAll(List.from(res));
  }

  getPageWidget(int index) {
    G.logger.i("当前页码-->" + index.toString());
    this.currentPageIndex = index;
    if (index == pages.length - 1) {
      this.fetchContent(index: ++this.currentChapterIndex);
    }
    return tc.getPageWidget(pages[index]);
  }

  void fetchContent({index: 0}) async {
    var cid = chapterList[index]['chapter_id'];
    var key = await API.getCptCmd(cid: cid);
    var ifm = await API.getCptIfm(cid: cid, key: key);
    String title = ifm['chapter_title'];
    // G.logger.i(ifm);
    String decryptContent =
        Decrypt.decrypt2Base64(ifm['txt_content'], keyStr: key);
    ifm['txt_content'] = decryptContent;
    tc = TextComposition(
        title: title + '\n',
        titleStyle:
            TextStyle(color: HexColor("#313131"), fontSize: 20, height: 4),
        // boxWidth: Get.context.width - 48,
        // boxHeight:
        //     Get.context.height - Get.statusBarHeight / Get.pixelRatio - 48,
        shouldJustifyHeight: true,
        style: TextStyle(
            // fontFamily: "noto",
            color: HexColor("#313131").withOpacity(0.9),
            fontSize: 16,
            height: 1.55),
        linkPattern: "<img",
        linkText: (s) =>
            RegExp(r"(?<=alt=').+?(?=')").firstMatch(s)?.group(0) ?? "图片",
        linkStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.normal),
        text: decryptContent,
        paragraphs: decryptContent.split("\n").map((s) => s.trim()).toList(),
        boxSize: Size(
          Get.context.width - 40,
          Get.context.height - Get.statusBarHeight / Get.pixelRatio - 96,
        ));
    pages.addAll(tc.pages);
    for (int i = 0; i < tc.pages.length; i++) {
      pageWs.add(Stack(
        key: ObjectKey({'cid': index, 'pid': i}),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 48, horizontal: 20),
            child: tc.getPageWidget(tc.pages[i]),
          ),
          Positioned(
            child: Container(
              height: 36,
              width: Get.context.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    i == 0 ? book.bookName : title,
                    style: TextStyle(
                        fontSize: 12,
                        color: HexColor("#313131").withOpacity(0.5)),
                  )
                ],
              ),
            ),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Container(
              height: 36,
              width: Get.context.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.bookName,
                    style: TextStyle(
                        fontSize: 12,
                        color: HexColor("#313131").withOpacity(0.5)),
                  ),
                  Text(
                    "${i + 1}/${tc.pages.length}",
                    style: TextStyle(
                        fontSize: 12,
                        color: HexColor("#313131").withOpacity(0.5)),
                  )
                ],
              ),
            ),
            bottom: 0,
            left: 0,
          )
        ],
      ));
    }
    update();
  }
}
