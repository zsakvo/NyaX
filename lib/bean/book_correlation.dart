// To parse this JSON data, do
//
//     final bookCorrelation = bookCorrelationFromJson(jsonString);

import 'dart:convert';

BookCorrelation bookCorrelationFromJson(String str) =>
    BookCorrelation.fromJson(json.decode(str));

String bookCorrelationToJson(BookCorrelation data) =>
    json.encode(data.toJson());

class BookCorrelation {
  BookCorrelation({
    this.listId,
    this.listName,
    this.listIntroduce,
    this.listCover,
    this.bookNum,
    this.favorNum,
    this.isFavor,
    this.readerInfo,
    this.bookInfoList,
  });

  String listId;
  String listName;
  String listIntroduce;
  String listCover;
  String bookNum;
  String favorNum;
  String isFavor;
  ReaderInfo readerInfo;
  List<BookInfoList> bookInfoList;

  factory BookCorrelation.fromJson(Map<String, dynamic> json) =>
      BookCorrelation(
        listId: json["list_id"] == null ? null : json["list_id"],
        listName: json["list_name"] == null ? null : json["list_name"],
        listIntroduce:
            json["list_introduce"] == null ? null : json["list_introduce"],
        listCover: json["list_cover"] == null ? null : json["list_cover"],
        bookNum: json["book_num"] == null ? null : json["book_num"],
        favorNum: json["favor_num"] == null ? null : json["favor_num"],
        isFavor: json["is_favor"] == null ? null : json["is_favor"],
        readerInfo: json["reader_info"] == null
            ? null
            : ReaderInfo.fromJson(json["reader_info"]),
        bookInfoList: json["book_info_list"] == null
            ? null
            : List<BookInfoList>.from(
                json["book_info_list"].map((x) => BookInfoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list_id": listId == null ? null : listId,
        "list_name": listName == null ? null : listName,
        "list_introduce": listIntroduce == null ? null : listIntroduce,
        "list_cover": listCover == null ? null : listCover,
        "book_num": bookNum == null ? null : bookNum,
        "favor_num": favorNum == null ? null : favorNum,
        "is_favor": isFavor == null ? null : isFavor,
        "reader_info": readerInfo == null ? null : readerInfo.toJson(),
        "book_info_list": bookInfoList == null
            ? null
            : List<dynamic>.from(bookInfoList.map((x) => x.toJson())),
      };
}

class BookInfoList {
  BookInfoList({
    this.bookId,
    this.bookName,
    this.cover,
    this.bookType,
    this.discount,
    this.discountEndTime,
  });

  String bookId;
  String bookName;
  String cover;
  String bookType;
  String discount;
  String discountEndTime;

  factory BookInfoList.fromJson(Map<String, dynamic> json) => BookInfoList(
        bookId: json["book_id"] == null ? null : json["book_id"],
        bookName: json["book_name"] == null ? null : json["book_name"],
        cover: json["cover"] == null ? null : json["cover"],
        bookType: json["book_type"] == null ? null : json["book_type"],
        discount: json["discount"] == null ? null : json["discount"],
        discountEndTime: json["discount_end_time"] == null
            ? null
            : json["discount_end_time"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "book_name": bookName == null ? null : bookName,
        "cover": cover == null ? null : cover,
        "book_type": bookType == null ? null : bookType,
        "discount": discount == null ? null : discount,
        "discount_end_time": discountEndTime == null ? null : discountEndTime,
      };
}

class ReaderInfo {
  ReaderInfo({
    this.readerId,
    this.readerName,
    this.gender,
    this.avatarThumbUrl,
    this.usedDecoration,
  });

  String readerId;
  String readerName;
  String gender;
  String avatarThumbUrl;
  List<UsedDecoration> usedDecoration;

  factory ReaderInfo.fromJson(Map<String, dynamic> json) => ReaderInfo(
        readerId: json["reader_id"] == null ? null : json["reader_id"],
        readerName: json["reader_name"] == null ? null : json["reader_name"],
        gender: json["gender"] == null ? null : json["gender"],
        avatarThumbUrl:
            json["avatar_thumb_url"] == null ? null : json["avatar_thumb_url"],
        usedDecoration: json["used_decoration"] == null
            ? null
            : List<UsedDecoration>.from(
                json["used_decoration"].map((x) => UsedDecoration.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reader_id": readerId == null ? null : readerId,
        "reader_name": readerName == null ? null : readerName,
        "gender": gender == null ? null : gender,
        "avatar_thumb_url": avatarThumbUrl == null ? null : avatarThumbUrl,
        "used_decoration": usedDecoration == null
            ? null
            : List<dynamic>.from(usedDecoration.map((x) => x.toJson())),
      };
}

class UsedDecoration {
  UsedDecoration({
    this.decorationType,
    this.decorationUrl,
  });

  String decorationType;
  String decorationUrl;

  factory UsedDecoration.fromJson(Map<String, dynamic> json) => UsedDecoration(
        decorationType:
            json["decoration_type"] == null ? null : json["decoration_type"],
        decorationUrl:
            json["decoration_url"] == null ? null : json["decoration_url"],
      );

  Map<String, dynamic> toJson() => {
        "decoration_type": decorationType == null ? null : decorationType,
        "decoration_url": decorationUrl == null ? null : decorationUrl,
      };
}
