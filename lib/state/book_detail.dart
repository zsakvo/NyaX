import 'package:get/get.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/bean/book_correlation.dart';

class BookDetailState {
  Rx<Book> book;
  RxList<BookCorrelation> bookCorrelationList;
  RxString bookCorrelationNum;
  RxBool isInShelf;
  RxBool isReady;

  BookDetailState() {
    book = Book().obs;
    bookCorrelationList = <BookCorrelation>[].obs;
    bookCorrelationNum = '0'.obs;
    isInShelf = false.obs;
    isReady = false.obs;
  }
}
