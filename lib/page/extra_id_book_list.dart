import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/extra_id_book_list.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:nyax/widget/loading.dart';

class ExtraIdBookListPage extends StatelessWidget {
  ExtraIdBookListPage({Key key}) : super(key: key);

  final ExtraIdBookListLogic logic =
      Get.put(ExtraIdBookListLogic(Get.arguments["lid"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          radius: 0.0,
          child: Container(
            width: 56,
            height: 56,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Image.asset("assets/image/ic_toolbar_left.png"),
          ),
          onTap: () {
            print("on tap toolbar menu");
            Navigator.pop(context);
          },
        ),
        title: Text(
          Get.arguments['title'],
          style: TextStyle(
              fontSize: 16,
              color: HexColor("#313131").withOpacity(0.9),
              fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
            child: Container(
              color: HexColor("#bdc3c7"),
              height: 0.1,
            ),
            preferredSize: Size.fromHeight(0.1)),
      ),
      body: GetBuilder<ExtraIdBookListLogic>(
        builder: (logic) {
          if (logic.bookList == null) {
            return Loading();
          } else {
            return ListView.builder(
              itemCount: logic.bookList.length,
              itemBuilder: (context, index) {
                return BookRow(logic.bookList[index]);
              },
            );
          }
        },
      ),
    );
  }
}
