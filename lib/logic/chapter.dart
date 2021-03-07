import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/util/decrypt.dart';
import 'package:text_composition/text_composition.dart';

import '../global.dart';
import '../widget/loading.dart';
// import 'package:nyax/widget/text_composition.dart';

class ChapterLogic extends GetxController {
  final Book book;
  ChapterLogic(this.book);

  List divisionList = [];
  List chapterList = [];
  List chapterIdList = [];

  TextComposition tc;

  List<TextPage> pages = [];
  List<Widget> pageWs = [Loading()];
  PageController pageController = PageController();

  int currentChapterIndex = 0;
  int currentPageIndex = 0;

  bool isLoading = false;

  Map<int, Chapter> cptMap = {};
  int allCptNum = 0;
  int preCptPageNum = 0;

  //存储本章的页码数目，和当前翻页比较 决定是否引入下一章

  @override
  void onInit() async {
    super.onInit();
    G.logger.i(book.toJson());
    await this.fetchDivisions();
    await fetchChapters();
    fetchContent(index: currentChapterIndex);
  }

  pageListener() async {
    if (pageController.position.isScrollingNotifier.value) {
      //在滚动呀
    } else {
      // ObjectKey key = pageWs[pageController.page.round()].key;
      // if (key != null) {
      //   var keyMap = Map<String, int>.from(key.value);
      //   this.currentChapterIndex = keyMap['cid'];
      // }
      if (pageController.page.round() > currentPageIndex) {
        //后翻页
        if (pageController.page.round() == allCptNum - 1) {
          // await nextPage();
          if (currentChapterIndex == chapterIdList.length - 1) return;
          fetchContent(index: this.currentChapterIndex + 1);
        }
        currentPageIndex = pageController.page.round();
      } else if (pageController.page.round() < currentPageIndex) {
        //前翻页
        if (pageController.page.round() == 0) {
          // int pageNumOld = pageWs.length;
          if (currentPageIndex == 0) return;
          fetchContent(index: this.currentChapterIndex - 1);
          // int pageNumNew = pageWs.length;
          // pageController.jumpToPage(
          //     pageController.page.round() + pageNumNew - pageNumOld);
          // currentPageIndex =
          //     pageController.page.round() + pageNumNew - pageNumOld;
        } else {
          currentPageIndex = pageController.page.round();
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

  getPageWidget(int index) {
    // G.logger.i("当前页码-->" + index.toString());
    // this.currentPageIndex = index;
    // if (index == pages.length - 1) {
    //   this.fetchContent(index: ++this.currentChapterIndex);
    // }
    // return tc.getPageWidget(pages[index]);
    TextPage page;
    print(chapterIdList[currentChapterIndex]);
    // if (index > preCptPageNum) {
    //   currentPageIndex = 0;
    //   currentChapterIndex++;
    // } else {
    //   // currentCptPageNum = index;
    // }
    page = cptMap[currentChapterIndex].pages[currentPageIndex];
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
                  index == 0 ? book.bookName : 'title',
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

  void fetchContent({index: 0, refresh: false}) async {
    if (isLoading) return;
    isLoading = true;
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
    pages.addAll(tc.pages);
    //
    Chapter chapter = Chapter(title, tc.pages, tc.pages.length);
    cptMap[index] = chapter;
    allCptNum += tc.pages.length;
    //
    List<Widget> tmpList = [];
    // for (int i = 0; i < tc.pages.length; i++) {
    //   tmpList.add(Stack(
    //     key: ObjectKey({'cid': index, 'pid': i}),
    //     children: [
    //       Container(
    //         padding: EdgeInsets.symmetric(vertical: 48, horizontal: 20),
    //         child: tc.getPageWidget(tc.pages[i],),
    //       ),
    //       Positioned(
    //         child: Container(
    //           height: 36,
    //           width: Get.context.width,
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(
    //                 i == 0 ? book.bookName : title,
    //                 style: TextStyle(
    //                     fontSize: 12,
    //                     color: HexColor("#313131").withOpacity(0.5)),
    //               )
    //             ],
    //           ),
    //         ),
    //         top: 0,
    //         left: 0,
    //       ),
    //       Positioned(
    //         child: Container(
    //           height: 36,
    //           width: Get.context.width,
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 book.bookName,
    //                 style: TextStyle(
    //                     fontSize: 12,
    //                     color: HexColor("#313131").withOpacity(0.5)),
    //               ),
    //               Text(
    //                 "${i + 1}/${tc.pages.length}",
    //                 style: TextStyle(
    //                     fontSize: 12,
    //                     color: HexColor("#313131").withOpacity(0.5)),
    //               )
    //             ],
    //           ),
    //         ),
    //         bottom: 0,
    //         left: 0,
    //       )
    //     ],
    //   ));
    // }
    // update();
    if (refresh) {
    } else {
      if (index == currentChapterIndex) {
        pageWs.addAll(tmpList);
        // pageController.jumpToPage(1);
      } else if (index > currentChapterIndex) {
        pageWs.addAll(tmpList);
      } else if (index < currentChapterIndex) {
        int pageNumOld = pageWs.length;
        pageWs.insertAll(1, tmpList);
        int pageNumNew = pageWs.length;
        pageController
            .jumpToPage(pageController.page.round() + pageNumNew - pageNumOld);
        currentPageIndex =
            pageController.page.round() + pageNumNew - pageNumOld;
      }
      update();
      isLoading = false;
    }
  }
}

class Chapter {
  final String title;
  final List<TextPage> pages;
  final int pageNum;
  Chapter(this.title, this.pages, this.pageNum);
}
