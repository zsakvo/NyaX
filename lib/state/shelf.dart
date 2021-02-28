import 'package:get/state_manager.dart';
import 'package:nyax/bean/book.dart';

class ShelfState {
  RxList<dynamic> shelfList;
  RxList<Book> bookList;
  RxString currentShelfId;
  RxString currentShelfName;
  RxInt currentPage;
  RxBool isReady;

  ShelfState() {
    shelfList = [].obs;
    bookList = <Book>[].obs;
    currentShelfId = "".obs;
    currentShelfName = "".obs;
    currentPage = 0.obs;
    isReady = false.obs;
  }
}
