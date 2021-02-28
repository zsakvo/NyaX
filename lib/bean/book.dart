// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  Book(
      {this.bookId,
      this.bookName,
      this.description,
      this.bookSrc,
      this.categoryIndex,
      this.tag,
      this.totalWordCount,
      this.upStatus,
      this.updateStatus,
      this.isPaid,
      this.discount,
      this.discountEndTime,
      this.cover,
      this.authorName,
      this.uptime,
      this.newtime,
      this.reviewAmount,
      this.rewardAmount,
      this.chapterAmount,
      this.isOriginal,
      this.totalClick,
      this.monthClick,
      this.weekClick,
      this.monthNoVipClick,
      this.weekNoVipClick,
      this.totalRecommend,
      this.monthRecommend,
      this.weekRecommend,
      this.totalFavor,
      this.monthFavor,
      this.weekFavor,
      this.currentYp,
      this.totalYp,
      this.currentBlade,
      this.totalBlade,
      this.weekFansValue,
      this.monthFansValue,
      this.totalFansValue,
      this.lastChapterInfo,
      this.tagList,
      this.bookType,
      this.transverseCover,
      this.gloryTag,
      this.bookComment,
      this.lastReadChapterId,
      this.lastReadChapterTitle,
      this.lastReadChapterUpdateTime});

  String bookId;
  String bookName;
  String description;
  String bookSrc;
  String categoryIndex;
  String tag;
  String totalWordCount;
  String upStatus;
  String updateStatus;
  String isPaid;
  String discount;
  String discountEndTime;
  String cover;
  String authorName;
  String uptime;
  String newtime;
  String reviewAmount;
  String rewardAmount;
  String chapterAmount;
  String isOriginal;
  String totalClick;
  String monthClick;
  String weekClick;
  String monthNoVipClick;
  String weekNoVipClick;
  String totalRecommend;
  String monthRecommend;
  String weekRecommend;
  String totalFavor;
  String monthFavor;
  String weekFavor;
  String currentYp;
  String totalYp;
  String currentBlade;
  String totalBlade;
  String weekFansValue;
  String monthFansValue;
  String totalFansValue;
  LastChapterInfo lastChapterInfo;
  List<TagList> tagList;
  String bookType;
  String transverseCover;
  GloryTag gloryTag;
  String bookComment;
  String lastReadChapterId;
  String lastReadChapterTitle;
  String lastReadChapterUpdateTime;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        bookId: json["book_id"] == null ? null : json["book_id"],
        bookName: json["book_name"] == null ? null : json["book_name"],
        description: json["description"] == null ? null : json["description"],
        bookSrc: json["book_src"] == null ? null : json["book_src"],
        categoryIndex:
            json["category_index"] == null ? null : json["category_index"],
        tag: json["tag"] == null ? null : json["tag"],
        totalWordCount:
            json["total_word_count"] == null ? null : json["total_word_count"],
        upStatus: json["up_status"] == null ? null : json["up_status"],
        updateStatus:
            json["update_status"] == null ? null : json["update_status"],
        isPaid: json["is_paid"] == null ? null : json["is_paid"],
        discount: json["discount"] == null ? null : json["discount"],
        discountEndTime: json["discount_end_time"] == null
            ? null
            : json["discount_end_time"],
        cover: json["cover"] == null ? null : json["cover"],
        authorName: json["author_name"] == null ? null : json["author_name"],
        uptime: json["uptime"] == null ? null : json["uptime"],
        newtime: json["newtime"] == null ? null : json["newtime"],
        reviewAmount:
            json["review_amount"] == null ? null : json["review_amount"],
        rewardAmount:
            json["reward_amount"] == null ? null : json["reward_amount"],
        chapterAmount:
            json["chapter_amount"] == null ? null : json["chapter_amount"],
        isOriginal: json["is_original"] == null ? null : json["is_original"],
        totalClick: json["total_click"] == null ? null : json["total_click"],
        monthClick: json["month_click"] == null ? null : json["month_click"],
        weekClick: json["week_click"] == null ? null : json["week_click"],
        monthNoVipClick: json["month_no_vip_click"] == null
            ? null
            : json["month_no_vip_click"],
        weekNoVipClick: json["week_no_vip_click"] == null
            ? null
            : json["week_no_vip_click"],
        totalRecommend:
            json["total_recommend"] == null ? null : json["total_recommend"],
        monthRecommend:
            json["month_recommend"] == null ? null : json["month_recommend"],
        weekRecommend:
            json["week_recommend"] == null ? null : json["week_recommend"],
        totalFavor: json["total_favor"] == null ? null : json["total_favor"],
        monthFavor: json["month_favor"] == null ? null : json["month_favor"],
        weekFavor: json["week_favor"] == null ? null : json["week_favor"],
        currentYp: json["current_yp"] == null ? null : json["current_yp"],
        totalYp: json["total_yp"] == null ? null : json["total_yp"],
        currentBlade:
            json["current_blade"] == null ? null : json["current_blade"],
        totalBlade: json["total_blade"] == null ? null : json["total_blade"],
        weekFansValue:
            json["week_fans_value"] == null ? null : json["week_fans_value"],
        monthFansValue:
            json["month_fans_value"] == null ? null : json["month_fans_value"],
        totalFansValue:
            json["total_fans_value"] == null ? null : json["total_fans_value"],
        lastChapterInfo: json["last_chapter_info"] == null
            ? null
            : LastChapterInfo.fromJson(json["last_chapter_info"]),
        tagList: json["tag_list"] == null
            ? null
            : List<TagList>.from(
                json["tag_list"].map((x) => TagList.fromJson(x))),
        bookType: json["book_type"] == null ? null : json["book_type"],
        transverseCover:
            json["transverse_cover"] == null ? null : json["transverse_cover"],
        gloryTag: json["glory_tag"] == null
            ? null
            : GloryTag.fromJson(json["glory_tag"]),
        bookComment: json["book_comment"] == null ? null : json["book_comment"],
        lastReadChapterId: json["last_read_chapter_id"] == null
            ? null
            : json["last_read_chapter_id"],
        lastReadChapterTitle: json["last_read_chapter_title"] == null
            ? null
            : json["last_read_chapter_title"],
        lastReadChapterUpdateTime: json["last_read_chapter_update_time"] == null
            ? null
            : json["last_read_chapter_update_time"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "book_name": bookName == null ? null : bookName,
        "description": description == null ? null : description,
        "book_src": bookSrc == null ? null : bookSrc,
        "category_index": categoryIndex == null ? null : categoryIndex,
        "tag": tag == null ? null : tag,
        "total_word_count": totalWordCount == null ? null : totalWordCount,
        "up_status": upStatus == null ? null : upStatus,
        "update_status": updateStatus == null ? null : updateStatus,
        "is_paid": isPaid == null ? null : isPaid,
        "discount": discount == null ? null : discount,
        "discount_end_time": discountEndTime == null ? null : discountEndTime,
        "cover": cover == null ? null : cover,
        "author_name": authorName == null ? null : authorName,
        "uptime": uptime == null ? null : uptime,
        "newtime": newtime == null ? null : newtime,
        "review_amount": reviewAmount == null ? null : reviewAmount,
        "reward_amount": rewardAmount == null ? null : rewardAmount,
        "chapter_amount": chapterAmount == null ? null : chapterAmount,
        "is_original": isOriginal == null ? null : isOriginal,
        "total_click": totalClick == null ? null : totalClick,
        "month_click": monthClick == null ? null : monthClick,
        "week_click": weekClick == null ? null : weekClick,
        "month_no_vip_click": monthNoVipClick == null ? null : monthNoVipClick,
        "week_no_vip_click": weekNoVipClick == null ? null : weekNoVipClick,
        "total_recommend": totalRecommend == null ? null : totalRecommend,
        "month_recommend": monthRecommend == null ? null : monthRecommend,
        "week_recommend": weekRecommend == null ? null : weekRecommend,
        "total_favor": totalFavor == null ? null : totalFavor,
        "month_favor": monthFavor == null ? null : monthFavor,
        "week_favor": weekFavor == null ? null : weekFavor,
        "current_yp": currentYp == null ? null : currentYp,
        "total_yp": totalYp == null ? null : totalYp,
        "current_blade": currentBlade == null ? null : currentBlade,
        "total_blade": totalBlade == null ? null : totalBlade,
        "week_fans_value": weekFansValue == null ? null : weekFansValue,
        "month_fans_value": monthFansValue == null ? null : monthFansValue,
        "total_fans_value": totalFansValue == null ? null : totalFansValue,
        "last_chapter_info":
            lastChapterInfo == null ? null : lastChapterInfo.toJson(),
        "tag_list": tagList == null
            ? null
            : List<dynamic>.from(tagList.map((x) => x.toJson())),
        "book_type": bookType == null ? null : bookType,
        "transverse_cover": transverseCover == null ? null : transverseCover,
        "glory_tag": gloryTag == null ? null : gloryTag.toJson(),
        "book_comment": bookComment == null ? null : bookComment,
        "last_read_chapter_id":
            lastReadChapterId == null ? null : lastReadChapterId,
        "last_read_chapter_title":
            lastReadChapterTitle == null ? null : lastReadChapterTitle,
        "last_read_chapter_update_time": lastReadChapterUpdateTime == null
            ? null
            : lastReadChapterUpdateTime,
      };
}

class GloryTag {
  GloryTag({
    this.tagName,
    this.cornerName,
    this.labelIcon,
    this.linkUrl,
  });

  String tagName;
  String cornerName;
  String labelIcon;
  String linkUrl;

  factory GloryTag.fromJson(Map<String, dynamic> json) => GloryTag(
        tagName: json["tag_name"] == null ? null : json["tag_name"],
        cornerName: json["corner_name"] == null ? null : json["corner_name"],
        labelIcon: json["label_icon"] == null ? null : json["label_icon"],
        linkUrl: json["link_url"] == null ? null : json["link_url"],
      );

  Map<String, dynamic> toJson() => {
        "tag_name": tagName == null ? null : tagName,
        "corner_name": cornerName == null ? null : cornerName,
        "label_icon": labelIcon == null ? null : labelIcon,
        "link_url": linkUrl == null ? null : linkUrl,
      };
}

class LastChapterInfo {
  LastChapterInfo({
    this.chapterId,
    this.bookId,
    this.chapterIndex,
    this.chapterTitle,
    this.uptime,
    this.mtime,
    this.recommendBookInfo,
  });

  String chapterId;
  String bookId;
  String chapterIndex;
  String chapterTitle;
  DateTime uptime;
  DateTime mtime;
  String recommendBookInfo;

  factory LastChapterInfo.fromJson(Map<String, dynamic> json) =>
      LastChapterInfo(
        chapterId: json["chapter_id"] == null ? null : json["chapter_id"],
        bookId: json["book_id"] == null ? null : json["book_id"],
        chapterIndex:
            json["chapter_index"] == null ? null : json["chapter_index"],
        chapterTitle:
            json["chapter_title"] == null ? null : json["chapter_title"],
        uptime: json["uptime"] == null ? null : DateTime.parse(json["uptime"]),
        mtime: json["mtime"] == null ? null : DateTime.parse(json["mtime"]),
        recommendBookInfo: json["recommend_book_info"] == null
            ? null
            : json["recommend_book_info"],
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId == null ? null : chapterId,
        "book_id": bookId == null ? null : bookId,
        "chapter_index": chapterIndex == null ? null : chapterIndex,
        "chapter_title": chapterTitle == null ? null : chapterTitle,
        "uptime": uptime == null ? null : uptime.toIso8601String(),
        "mtime": mtime == null ? null : mtime.toIso8601String(),
        "recommend_book_info":
            recommendBookInfo == null ? null : recommendBookInfo,
      };
}

class TagList {
  TagList({
    this.tagId,
    this.tagType,
    this.tagName,
  });

  String tagId;
  String tagType;
  String tagName;

  factory TagList.fromJson(Map<String, dynamic> json) => TagList(
        tagId: json["tag_id"] == null ? null : json["tag_id"],
        tagType: json["tag_type"] == null ? null : json["tag_type"],
        tagName: json["tag_name"] == null ? null : json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId == null ? null : tagId,
        "tag_type": tagType == null ? null : tagType,
        "tag_name": tagName == null ? null : tagName,
      };
}
