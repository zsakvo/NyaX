import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/widget/book_row.dart';

class ExtraBookListPage extends StatelessWidget {
  const ExtraBookListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var module = Get.arguments;
    List books = List.from(module["list"]).toList();
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
          module["title"],
          style: TextStyle(
              fontSize: 16,
              color: HexColor("#313131").withOpacity(0.9),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemExtent: 120,
        itemBuilder: (context, index) {
          return BookRow(books[index]);
        },
      ),
    );
  }
}
