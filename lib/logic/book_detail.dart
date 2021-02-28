import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/state/book_detail.dart';

class BookDetailLogic extends GetxController {
  final state = BookDetailState();

  void fetchDatas(bid) async {
    var res = await API.getBookInfo(bid);
    // G.logger.d(res['book_info']);
    state.isInShelf(res['is_inshelf'] == "0");
    state.book(bookFromJson(json.encode(res['book_info'])));
    state.isReady(true);
  }
}
