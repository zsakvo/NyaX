import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/bean/book.dart';

class BookRow extends StatefulWidget {
  final Book book;

  BookRow(this.book, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BookRowState();
  }
}

class BookRowState extends State<BookRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: this.widget.book.cover, width: 70, height: 98),
            SizedBox(
              width: 16,
            ),
            Container(
              width: Get.width - 118,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    this.widget.book.bookName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#313131").withOpacity(0.9),
                        fontSize: 15,
                        height: 1.7),
                  ),
                  Text(
                    this.widget.book.authorName,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: HexColor("#313131").withOpacity(0.5),
                        fontSize: 13,
                        height: 1.7),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      this.widget.book.description,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: HexColor("#313131").withOpacity(0.5),
                          fontSize: 13,
                          height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        // CwmRouter.push("cwm://BookDetailPage", book.bookId);
      },
    );
  }
}
