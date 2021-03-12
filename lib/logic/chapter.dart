import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/util/decrypt.dart';
import 'package:nyax/widget/loading.dart';
import 'package:text_composition/text_composition.dart';

import '../global.dart';
// import 'package:nyax/widget/text_composition.dart';

class ChapterLogic extends GetxController {
  final Book book;
  ChapterLogic(this.book);

  //分卷列表
  List divisionList = [];
  //章节列表
  List chapterList = [];
  //章节 id 列表
  List chapterIdList = [];

  //分页实例列表
  // List<TextComposition> tcs = [];

  //pageView 控制器
  PageController pageController = PageController();

  //当前章节序号
  int currentChapterIndex = 0;

  //当前页码
  int currentPage = 0;

  //正在获取内容
  bool isLoading = false;

  //章节序号与 Chapter 实例映射
  Map<int, Chapter> cptMap = {};

  //总页码
  int allChapterPage = 0;
  //下一章的页码
  int nextChapterPage = 0;

  //页面 Widget 列表
  List<Widget> pages = [Loading()];

  //第一章序号
  int firstChapterIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    await this.fetchDivisions();
    await fetchChapters();

    fetchContent(index: currentChapterIndex);
  }

  pageListener() async {
    if (pageController.position.isScrollingNotifier.value) {
      //在滚动呀
    } else {
      ObjectKey key = pages[pageController.page.round()].key;
      if (key != null) {
        var keyMap = Map<String, int>.from(key.value);
        this.currentChapterIndex = keyMap['cid'];
      }
      if (pageController.page.round() > currentPage) {
        //后翻页
        if (pageController.page.round() == pages.length - 1) {
          // await nextPage();
          if (currentChapterIndex == chapterIdList.length - 1) return;
          fetchContent(index: this.currentChapterIndex + 1);
        }
        currentPage = pageController.page.round();
      } else if (pageController.page.round() < currentPage) {
        //前翻页
        if (pageController.page.round() == 0) {
          int pageNumOld = pages.length;
          if (currentChapterIndex == 0) return;
          await fetchContent(index: this.currentChapterIndex - 1);
          int pageNumNew = pages.length;
          pageController.jumpToPage(
              pageController.page.round() + pageNumNew - pageNumOld);
          currentPage = pageController.page.round() + pageNumNew - pageNumOld;
        } else {
          currentPage = pageController.page.round();
        }
      }
    }
  }

  fetchDivisions() async {
    var res = await API.getDivisionList(bid: book.bookId);
    divisionList = List.from(res);
  }

  fetchChapters() async {
    await Future.forEach(divisionList, (d) async {
      var res = await API.getChapterListByDivisionId(did: d['division_id']);
      chapterList.addAll(List.from(res));
    });
    chapterList.asMap().forEach((i, c) {
      chapterIdList.add(c['chapter_id']);
      if (book.lastReadChapterId != null &&
          c['chapter_id'] == book.lastReadChapterId) {
        currentChapterIndex = i;
      }
    });
    G.logger.i(currentChapterIndex);
  }

  getPageWidget(int currentChapterIndex, String title, TextComposition tc,
      TextPage page, int index) {
    return Stack(
      key: ObjectKey({'cid': currentChapterIndex, 'pid': index}),
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 48, horizontal: 20),
          child: tc.getPageWidget(
            page,
          ),
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
                  index == 0 ? book.bookName : title,
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
                  "${index + 1}/${tc.pages.length}",
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
    );
  }

  fetchContent({index: 0, refresh: false}) async {
    if (isLoading) return;
    isLoading = true;
    var cid = chapterList[index]['chapter_id'];
    var key = await API.getCptCmd(cid: cid);
    var ifm = await API.getCptIfm(cid: cid, key: key);
    String title = ifm['chapter_title'];
    String decryptContent =
        Decrypt.decrypt2Base64(ifm['txt_content'], keyStr: key);
    ifm['txt_content'] = decryptContent;
    TextComposition tc = TextComposition(
        title: title + '\n',
        titleStyle: TextStyle(
            color: HexColor("#313131"),
            fontSize: 20,
            height: 3,
            fontWeight: FontWeight.normal),
        shouldJustifyHeight: true,
        paragraph: 16,
        style: TextStyle(
            // fontFamily: "noto",
            color: HexColor("#313131").withOpacity(0.9),
            fontSize: 16,
            height: 1.55),
        linkPattern: "<img",
        linkText: (s) =>
            "【图】" + RegExp(r"(?<=alt=').+?(?=')").firstMatch(s)?.group(0) ??
            "图片",
        linkStyle: TextStyle(
            color: Colors.blue, fontStyle: FontStyle.normal, fontSize: 16),
        text: decryptContent,
        paragraphs: decryptContent.split("\n").map((s) => s.trim()).toList(),
        boxSize: Size(
          Get.context.width - 40,
          Get.context.height - Get.statusBarHeight / Get.pixelRatio - 96,
        ));
    List<Widget> w = [];
    tc.pages.asMap().forEach((key, page) {
      w.add(getPageWidget(index, title, tc, page, key));
    });
    if (index > currentChapterIndex) {
      pages.addAll(w);
    } else {
      pages.insertAll(1, w);
    }
    update();
    if (pages.length == w.length + 1) {
      pageController.jumpToPage(1);
    }
    isLoading = false;
  }
}

class Chapter {
  final String title;
  final TextComposition tc;
  final List<TextPage> pages;
  final int pageNum;
  Chapter(this.title, this.tc, this.pages, this.pageNum);
}
