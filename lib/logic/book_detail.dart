import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/book_correlation.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/state/book_detail.dart';

import '../http/api.dart';

class BookDetailLogic extends GetxController {
  final state = BookDetailState();

  void fetchDatas(bid) async {
    var res = await API.getBookInfo(bid);
    // G.logger.d(res['book_info']);
    state.isInShelf(res['is_inshelf'] != "0");
    state.book(bookFromJson(json.encode(res['book_info'])));
    state.isReady(true);
    var res2 = await API.getBookCorrelationLists(bid);
    // G.logger.d(res2);
    state.bookCorrelationNum(res2['booklistnum']);
    List.from(res2['booklists']).forEach((ele) {
      state.bookCorrelationList.add(bookCorrelationFromJson(json.encode(ele)));
    });
  }
}
