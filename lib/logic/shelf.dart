import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/api.dart';
import 'package:nyax/state/shelf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShelfLogic extends GetxController {
  final state = ShelfState();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  _fetchShelfList() async {
    var res = await API.getShelfList();
    G.logger.d(res);
    state.shelfList(List.from(res));
  }

  void fetchDatas() async {
    await _fetchShelfList();
    state.currentShelfId(state.shelfList[0]['shelf_id']);
    state.currentShelfName(state.shelfList[0]['shelf_name']);
    var res = await API.getShelfBookList(
        shelfId: state.currentShelfId, page: state.currentPage);
    List.from(res).forEach((r) {
      var bookInfo = r['book_info'];
      bookInfo['last_read_chapter_id'] = r['last_read_chapter_id'];
      bookInfo['last_read_chapter_title'] = r['last_read_chapter_title'];
      bookInfo['last_read_chapter_update_time'] =
          r['last_read_chapter_update_time'];
      Book book = bookFromJson(json.encode(bookInfo));
      state.bookList.add(book);
    });
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    if (!state.isReady.value) state.isReady(true);
  }

  refresh() {
    state.bookList([]);
    state.currentPage(0);
    this.fetchDatas();
  }

  nextPage() {
    state.currentPage++;
    this.fetchDatas();
  }
}
