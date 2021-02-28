import 'package:get/get.dart';
import 'package:nyax/bean/book.dart';

class BookDetailState {
  Rx<Book> book;
  RxBool isInShelf;
  RxBool isReady;

  BookDetailState() {
    book = Book().obs;
    isInShelf = false.obs;
    isReady = false.obs;
  }
}
