import 'dart:convert';

Module moduleFromJson(String str) => Module.fromJson(json.decode(str));

String moduleToJson(Module data) => json.encode(data.toJson());

class Module {
  Module({
    this.moduleType,
    this.bossModule,
    this.listId,
    this.moduleId,
    this.moduleTitle,
    this.moduleIntroduce,
    this.moduleImage,
    this.ciweicatModuleImage,
    this.rightButtonType,
    this.internalModuleTitle,
    this.picBookList,
    this.picBookInfo,
    this.txtBookList,
    this.specialModuleList,
    this.desBookList,
    this.header,
    this.editorModule,
    this.singleBooklist,
    this.listUrl,
    this.moreBooklist,
  });

  String moduleType;
  BossModule bossModule;
  String listId;
  String moduleId;
  String moduleTitle;
  String moduleIntroduce;
  String moduleImage;
  String ciweicatModuleImage;
  String rightButtonType;
  String internalModuleTitle;
  List<PicBookInfo> picBookList;
  PicBookInfo picBookInfo;
  List<TxtBookList> txtBookList;
  List<SpecialModuleList> specialModuleList;
  List<DesBookList> desBookList;
  List<Header> header;
  EditorModule editorModule;
  SingleBooklist singleBooklist;
  String listUrl;
  List<MoreBooklist> moreBooklist;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleType: json["module_type"] == null ? null : json["module_type"],
        bossModule: json["boss_module"] == null
            ? null
            : BossModule.fromJson(json["boss_module"]),
        listId: json["list_id"] == null ? null : json["list_id"],
        moduleId: json["module_id"] == null ? null : json["module_id"],
        moduleTitle: json["module_title"] == null ? null : json["module_title"],
        moduleIntroduce:
            json["module_introduce"] == null ? null : json["module_introduce"],
        moduleImage: json["module_image"] == null ? null : json["module_image"],
        ciweicatModuleImage: json["ciweicat_module_image"] == null
            ? null
            : json["ciweicat_module_image"],
        rightButtonType: json["right_button_type"] == null
            ? null
            : json["right_button_type"],
        internalModuleTitle: json["internal_module_title"] == null
            ? null
            : json["internal_module_title"],
        picBookList: json["pic_book_list"] == null
            ? null
            : List<PicBookInfo>.from(
                json["pic_book_list"].map((x) => PicBookInfo.fromJson(x))),
        picBookInfo: json["pic_book_info"] == null
            ? null
            : PicBookInfo.fromJson(json["pic_book_info"]),
        txtBookList: json["txt_book_list"] == null
            ? null
            : List<TxtBookList>.from(
                json["txt_book_list"].map((x) => TxtBookList.fromJson(x))),
        specialModuleList: json["special_module_list"] == null
            ? null
            : List<SpecialModuleList>.from(json["special_module_list"]
                .map((x) => SpecialModuleList.fromJson(x))),
        desBookList: json["des_book_list"] == null
            ? null
            : List<DesBookList>.from(
                json["des_book_list"].map((x) => DesBookList.fromJson(x))),
        header: json["header"] == null
            ? null
            : List<Header>.from(json["header"].map((x) => Header.fromJson(x))),
        editorModule: json["editor_module"] == null
            ? null
            : EditorModule.fromJson(json["editor_module"]),
        singleBooklist: json["single_booklist"] == null
            ? null
            : SingleBooklist.fromJson(json["single_booklist"]),
        listUrl: json["list_url"] == null ? null : json["list_url"],
        moreBooklist: json["more_booklist"] == null
            ? null
            : List<MoreBooklist>.from(
                json["more_booklist"].map((x) => MoreBooklist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "module_type": moduleType == null ? null : moduleType,
        "boss_module": bossModule == null ? null : bossModule.toJson(),
        "list_id": listId == null ? null : listId,
        "module_id": moduleId == null ? null : moduleId,
        "module_title": moduleTitle == null ? null : moduleTitle,
        "module_introduce": moduleIntroduce == null ? null : moduleIntroduce,
        "module_image": moduleImage == null ? null : moduleImage,
        "ciweicat_module_image":
            ciweicatModuleImage == null ? null : ciweicatModuleImage,
        "right_button_type": rightButtonType == null ? null : rightButtonType,
        "internal_module_title":
            internalModuleTitle == null ? null : internalModuleTitle,
        "pic_book_list": picBookList == null
            ? null
            : List<dynamic>.from(picBookList.map((x) => x.toJson())),
        "pic_book_info": picBookInfo == null ? null : picBookInfo.toJson(),
        "txt_book_list": txtBookList == null
            ? null
            : List<dynamic>.from(txtBookList.map((x) => x.toJson())),
        "special_module_list": specialModuleList == null
            ? null
            : List<dynamic>.from(specialModuleList.map((x) => x.toJson())),
        "des_book_list": desBookList == null
            ? null
            : List<dynamic>.from(desBookList.map((x) => x.toJson())),
        "header": header == null
            ? null
            : List<dynamic>.from(header.map((x) => x.toJson())),
        "editor_module": editorModule == null ? null : editorModule.toJson(),
        "single_booklist":
            singleBooklist == null ? null : singleBooklist.toJson(),
        "list_url": listUrl == null ? null : listUrl,
        "more_booklist": moreBooklist == null
            ? null
            : List<dynamic>.from(moreBooklist.map((x) => x.toJson())),
      };
}

class BossModule {
  BossModule({
    this.moduleImage,
    this.ciweicatModuleImage,
    this.listId,
    this.listUrl,
    this.desBookList,
    this.rightButtonType,
  });

  String moduleImage;
  String ciweicatModuleImage;
  String listId;
  String listUrl;
  List<PicBookInfo> desBookList;
  String rightButtonType;

  factory BossModule.fromJson(Map<String, dynamic> json) => BossModule(
        moduleImage: json["module_image"] == null ? null : json["module_image"],
        ciweicatModuleImage: json["ciweicat_module_image"] == null
            ? null
            : json["ciweicat_module_image"],
        listId: json["list_id"] == null ? null : json["list_id"],
        listUrl: json["list_url"] == null ? null : json["list_url"],
        desBookList: json["des_book_list"] == null
            ? null
            : List<PicBookInfo>.from(
                json["des_book_list"].map((x) => PicBookInfo.fromJson(x))),
        rightButtonType: json["right_button_type"] == null
            ? null
            : json["right_button_type"],
      );

  Map<String, dynamic> toJson() => {
        "module_image": moduleImage == null ? null : moduleImage,
        "ciweicat_module_image":
            ciweicatModuleImage == null ? null : ciweicatModuleImage,
        "list_id": listId == null ? null : listId,
        "list_url": listUrl == null ? null : listUrl,
        "des_book_list": desBookList == null
            ? null
            : List<dynamic>.from(desBookList.map((x) => x.toJson())),
        "right_button_type": rightButtonType == null ? null : rightButtonType,
      };
}

class PicBookInfo {
  PicBookInfo({
    this.bookId,
    this.bookName,
    this.categoryIndex,
    this.description,
    this.authorName,
    this.cover,
    this.discount,
    this.discountEndTime,
    this.gloryTag,
    this.totalClick,
    this.isOriginal,
    this.introduce,
    this.upStatus,
    this.totalWordCount,
    this.totalFavor,
    this.upReaderId,
  });

  String bookId;
  String bookName;
  String categoryIndex;
  String description;
  String authorName;
  String cover;
  String discount;
  String discountEndTime;
  GloryTag gloryTag;
  String totalClick;
  String isOriginal;
  String introduce;
  String upStatus;
  String totalWordCount;
  String totalFavor;
  String upReaderId;

  factory PicBookInfo.fromJson(Map<String, dynamic> json) => PicBookInfo(
        bookId: json["book_id"] == null ? null : json["book_id"],
        bookName: json["book_name"] == null ? null : json["book_name"],
        categoryIndex:
            json["category_index"] == null ? null : json["category_index"],
        description: json["description"] == null ? null : json["description"],
        authorName: json["author_name"] == null ? null : json["author_name"],
        cover: json["cover"] == null ? null : json["cover"],
        discount: json["discount"] == null ? null : json["discount"],
        discountEndTime: json["discount_end_time"] == null
            ? null
            : json["discount_end_time"],
        gloryTag: json["glory_tag"] == null
            ? null
            : GloryTag.fromJson(json["glory_tag"]),
        totalClick: json["total_click"] == null ? null : json["total_click"],
        isOriginal: json["is_original"] == null ? null : json["is_original"],
        introduce: json["introduce"] == null ? null : json["introduce"],
        upStatus: json["up_status"] == null ? null : json["up_status"],
        totalWordCount:
            json["total_word_count"] == null ? null : json["total_word_count"],
        totalFavor: json["total_favor"] == null ? null : json["total_favor"],
        upReaderId: json["up_reader_id"] == null ? null : json["up_reader_id"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "book_name": bookName == null ? null : bookName,
        "category_index": categoryIndex == null ? null : categoryIndex,
        "description": description == null ? null : description,
        "author_name": authorName == null ? null : authorName,
        "cover": cover == null ? null : cover,
        "discount": discount == null ? null : discount,
        "discount_end_time": discountEndTime == null ? null : discountEndTime,
        "glory_tag": gloryTag == null ? null : gloryTag.toJson(),
        "total_click": totalClick == null ? null : totalClick,
        "is_original": isOriginal == null ? null : isOriginal,
        "introduce": introduce == null ? null : introduce,
        "up_status": upStatus == null ? null : upStatus,
        "total_word_count": totalWordCount == null ? null : totalWordCount,
        "total_favor": totalFavor == null ? null : totalFavor,
        "up_reader_id": upReaderId == null ? null : upReaderId,
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

class DesBookList {
  DesBookList({
    this.bookId,
    this.bookName,
    this.categoryIndex,
    this.authorName,
    this.description,
    this.totalClick,
  });

  String bookId;
  String bookName;
  String categoryIndex;
  String authorName;
  String description;
  String totalClick;

  factory DesBookList.fromJson(Map<String, dynamic> json) => DesBookList(
        bookId: json["book_id"] == null ? null : json["book_id"],
        bookName: json["book_name"] == null ? null : json["book_name"],
        categoryIndex:
            json["category_index"] == null ? null : json["category_index"],
        authorName: json["author_name"] == null ? null : json["author_name"],
        description: json["description"] == null ? null : json["description"],
        totalClick: json["total_click"] == null ? null : json["total_click"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "book_name": bookName == null ? null : bookName,
        "category_index": categoryIndex == null ? null : categoryIndex,
        "author_name": authorName == null ? null : authorName,
        "description": description == null ? null : description,
        "total_click": totalClick == null ? null : totalClick,
      };
}

class EditorModule {
  EditorModule({
    this.moduleImage,
    this.ciweicatModuleImage,
    this.moduleTitle,
    this.listId,
    this.listUrl,
    this.desBookList,
    this.changeButtonType,
  });

  String moduleImage;
  String ciweicatModuleImage;
  String moduleTitle;
  String listId;
  String listUrl;
  List<PicBookInfo> desBookList;
  String changeButtonType;

  factory EditorModule.fromJson(Map<String, dynamic> json) => EditorModule(
        moduleImage: json["module_image"] == null ? null : json["module_image"],
        ciweicatModuleImage: json["ciweicat_module_image"] == null
            ? null
            : json["ciweicat_module_image"],
        moduleTitle: json["module_title"] == null ? null : json["module_title"],
        listId: json["list_id"] == null ? null : json["list_id"],
        listUrl: json["list_url"] == null ? null : json["list_url"],
        desBookList: json["des_book_list"] == null
            ? null
            : List<PicBookInfo>.from(
                json["des_book_list"].map((x) => PicBookInfo.fromJson(x))),
        changeButtonType: json["change_button_type"] == null
            ? null
            : json["change_button_type"],
      );

  Map<String, dynamic> toJson() => {
        "module_image": moduleImage == null ? null : moduleImage,
        "ciweicat_module_image":
            ciweicatModuleImage == null ? null : ciweicatModuleImage,
        "module_title": moduleTitle == null ? null : moduleTitle,
        "list_id": listId == null ? null : listId,
        "list_url": listUrl == null ? null : listUrl,
        "des_book_list": desBookList == null
            ? null
            : List<dynamic>.from(desBookList.map((x) => x.toJson())),
        "change_button_type":
            changeButtonType == null ? null : changeButtonType,
      };
}

class MoreBooklist {
  MoreBooklist({
    this.listId,
    this.listCover,
  });

  String listId;
  String listCover;

  factory MoreBooklist.fromJson(Map<String, dynamic> json) => MoreBooklist(
        listId: json["list_id"] == null ? null : json["list_id"],
        listCover: json["list_cover"] == null ? null : json["list_cover"],
      );

  Map<String, dynamic> toJson() => {
        "list_id": listId == null ? null : listId,
        "list_cover": listCover == null ? null : listCover,
      };
}

class SingleBooklist {
  SingleBooklist({
    this.listId,
    this.listUrl,
    this.listCover,
  });

  String listId;
  String listUrl;
  String listCover;

  factory SingleBooklist.fromJson(Map<String, dynamic> json) => SingleBooklist(
        listId: json["list_id"] == null ? null : json["list_id"],
        listUrl: json["list_url"] == null ? null : json["list_url"],
        listCover: json["list_cover"] == null ? null : json["list_cover"],
      );

  Map<String, dynamic> toJson() => {
        "list_id": listId == null ? null : listId,
        "list_url": listUrl == null ? null : listUrl,
        "list_cover": listCover == null ? null : listCover,
      };
}

class SpecialModuleList {
  SpecialModuleList({
    this.moduleTitle,
    this.moduleIntroduce,
    this.modulePic,
    this.listId,
    this.ciweicatModulePic,
    this.specialModuleId,
  });

  String moduleTitle;
  String moduleIntroduce;
  String modulePic;
  String listId;
  String ciweicatModulePic;
  String specialModuleId;

  factory SpecialModuleList.fromJson(Map<String, dynamic> json) =>
      SpecialModuleList(
        moduleTitle: json["module_title"] == null ? null : json["module_title"],
        moduleIntroduce:
            json["module_introduce"] == null ? null : json["module_introduce"],
        modulePic: json["module_pic"] == null ? null : json["module_pic"],
        listId: json["list_id"] == null ? null : json["list_id"],
        ciweicatModulePic: json["ciweicat_module_pic"] == null
            ? null
            : json["ciweicat_module_pic"],
        specialModuleId: json["special_module_id"] == null
            ? null
            : json["special_module_id"],
      );

  Map<String, dynamic> toJson() => {
        "module_title": moduleTitle == null ? null : moduleTitle,
        "module_introduce": moduleIntroduce == null ? null : moduleIntroduce,
        "module_pic": modulePic == null ? null : modulePic,
        "list_id": listId == null ? null : listId,
        "ciweicat_module_pic":
            ciweicatModulePic == null ? null : ciweicatModulePic,
        "special_module_id": specialModuleId == null ? null : specialModuleId,
      };
}

class TxtBookList {
  TxtBookList({
    this.bookId,
    this.categoryIndex,
    this.totalClick,
    this.introduce,
  });

  String bookId;
  String categoryIndex;
  String totalClick;
  String introduce;

  factory TxtBookList.fromJson(Map<String, dynamic> json) => TxtBookList(
        bookId: json["book_id"] == null ? null : json["book_id"],
        categoryIndex:
            json["category_index"] == null ? null : json["category_index"],
        totalClick: json["total_click"] == null ? null : json["total_click"],
        introduce: json["introduce"] == null ? null : json["introduce"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "category_index": categoryIndex == null ? null : categoryIndex,
        "total_click": totalClick == null ? null : totalClick,
        "introduce": introduce == null ? null : introduce,
      };
}

class Header {
  Header({
    this.title,
    this.innerApp,
    this.tabType,
    this.isSelect,
  });

  String title;
  String innerApp;
  String tabType;
  String isSelect;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        title: json["title"] == null ? null : json["title"],
        innerApp: json["inner_app"] == null ? null : json["inner_app"],
        tabType: json["tab_type"] == null ? null : json["tab_type"],
        isSelect: json["is_select"] == null ? null : json["is_select"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "inner_app": innerApp == null ? null : innerApp,
        "tab_type": tabType == null ? null : tabType,
        "is_select": isSelect == null ? null : isSelect,
      };
}
