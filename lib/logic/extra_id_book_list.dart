import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nyax/bean/book.dart';
import 'package:nyax/http/api.dart';

class ExtraIdBookListLogic extends GetxController {
  String lid = '1';
  List<Book> bookList;

  ExtraIdBookListLogic(this.lid);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      this.fetchDatas();
    });
  }

  void fetchDatas() async {
    var res = await API.getBookList(this.lid);
    bookList = [];
    List.from(res).forEach((r) {
      Book book = Book.fromJson(r);
      bookList.add(book);
    });
    update();
  }
}
