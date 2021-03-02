import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/util/decrypt.dart';
import 'package:nyax/widget/text_composition.dart';

class ChapterLogic extends GetxController {
  final Book book;
  ChapterLogic(this.book);

  List divisionList = [];
  List chapterList = [];

  TextComposition tc;

  List<TextPage> pages;

  @override
  void onInit() async {
    G.logger.d(book.bookName +
        "\n" +
        Get.context.width.toString() +
        "\n" +
        Get.context.height.toString());
    super.onInit();
    await this.fetchDivisions();
    await fetchChapters();
    fetchContent();
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

  void fetchContent() async {
    var cid = chapterList[0]['chapter_id'];
    var res1 = await API.getCptCmd(cid: cid);
    var res2 = await API.getCptIfm(cid: cid, key: res1);
    String decryptContent =
        Decrypt.decrypt2Base64(res2['txt_content'], keyStr: res1);
    res2['txt_content'] = decryptContent;
    tc = TextComposition(
        boxWidth: Get.context.width - 48,
        boxHeight: Get.context.height -
            Get.statusBarHeight / Get.window.devicePixelRatio -
            48,
        shouldJustifyHeight: true,
        // style: TextStyle(
        //     color: HexColor("#313131").withOpacity(0.9),
        //     fontSize: 16,
        //     height: 1.4),
        // linkPattern: "<img",
        // linkText: (s) =>
        //     RegExp(r"(?<=alt=').+?(?=')").firstMatch(s)?.group(0) ?? "图片",
        // linkStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.normal),
        // text: decryptContent,
        paragraphs: decryptContent.split("\n").map((s) => s.trim()).toList());
    pages = tc.pages;
    update();
  }
}
