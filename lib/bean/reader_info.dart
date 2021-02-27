// To parse this JSON data, do
//
//     final readerInfo = readerInfoFromJson(jsonString);

import 'dart:convert';

ReaderInfo readerInfoFromJson(String str) =>
    ReaderInfo.fromJson(json.decode(str));

String readerInfoToJson(ReaderInfo data) => json.encode(data.toJson());

class ReaderInfo {
  ReaderInfo({
    this.readerId,
    this.account,
    this.isBind,
    this.isBindQq,
    this.isBindWeixin,
    this.isBindHuawei,
    this.isBindApple,
    this.phoneNum,
    this.mobileVal,
    this.email,
    this.license,
    this.readerName,
    this.avatarUrl,
    this.avatarThumbUrl,
    this.baseStatus,
    this.expLv,
    this.expValue,
    this.gender,
    this.vipLv,
    this.vipValue,
    this.isAuthor,
    this.isUploader,
    this.bookAge,
    this.categoryPrefer,
    this.usedDecoration,
    this.rank,
    this.ctime,
  });

  String readerId;
  String account;
  String isBind;
  String isBindQq;
  String isBindWeixin;
  String isBindHuawei;
  String isBindApple;
  String phoneNum;
  String mobileVal;
  String email;
  String license;
  String readerName;
  String avatarUrl;
  String avatarThumbUrl;
  String baseStatus;
  String expLv;
  String expValue;
  String gender;
  String vipLv;
  String vipValue;
  String isAuthor;
  String isUploader;
  String bookAge;
  List<dynamic> categoryPrefer;
  List<dynamic> usedDecoration;
  String rank;
  DateTime ctime;

  factory ReaderInfo.fromJson(Map<String, dynamic> json) => ReaderInfo(
        readerId: json["reader_id"] == null ? null : json["reader_id"],
        account: json["account"] == null ? null : json["account"],
        isBind: json["is_bind"] == null ? null : json["is_bind"],
        isBindQq: json["is_bind_qq"] == null ? null : json["is_bind_qq"],
        isBindWeixin:
            json["is_bind_weixin"] == null ? null : json["is_bind_weixin"],
        isBindHuawei:
            json["is_bind_huawei"] == null ? null : json["is_bind_huawei"],
        isBindApple:
            json["is_bind_apple"] == null ? null : json["is_bind_apple"],
        phoneNum: json["phone_num"] == null ? null : json["phone_num"],
        mobileVal: json["mobileVal"] == null ? null : json["mobileVal"],
        email: json["email"] == null ? null : json["email"],
        license: json["license"] == null ? null : json["license"],
        readerName: json["reader_name"] == null ? null : json["reader_name"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        avatarThumbUrl:
            json["avatar_thumb_url"] == null ? null : json["avatar_thumb_url"],
        baseStatus: json["base_status"] == null ? null : json["base_status"],
        expLv: json["exp_lv"] == null ? null : json["exp_lv"],
        expValue: json["exp_value"] == null ? null : json["exp_value"],
        gender: json["gender"] == null ? null : json["gender"],
        vipLv: json["vip_lv"] == null ? null : json["vip_lv"],
        vipValue: json["vip_value"] == null ? null : json["vip_value"],
        isAuthor: json["is_author"] == null ? null : json["is_author"],
        isUploader: json["is_uploader"] == null ? null : json["is_uploader"],
        bookAge: json["book_age"] == null ? null : json["book_age"],
        categoryPrefer: json["category_prefer"] == null
            ? null
            : List<dynamic>.from(json["category_prefer"].map((x) => x)),
        usedDecoration: json["used_decoration"] == null
            ? null
            : List<dynamic>.from(json["used_decoration"].map((x) => x)),
        rank: json["rank"] == null ? null : json["rank"],
        ctime: json["ctime"] == null ? null : DateTime.parse(json["ctime"]),
      );

  Map<String, dynamic> toJson() => {
        "reader_id": readerId == null ? null : readerId,
        "account": account == null ? null : account,
        "is_bind": isBind == null ? null : isBind,
        "is_bind_qq": isBindQq == null ? null : isBindQq,
        "is_bind_weixin": isBindWeixin == null ? null : isBindWeixin,
        "is_bind_huawei": isBindHuawei == null ? null : isBindHuawei,
        "is_bind_apple": isBindApple == null ? null : isBindApple,
        "phone_num": phoneNum == null ? null : phoneNum,
        "mobileVal": mobileVal == null ? null : mobileVal,
        "email": email == null ? null : email,
        "license": license == null ? null : license,
        "reader_name": readerName == null ? null : readerName,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "avatar_thumb_url": avatarThumbUrl == null ? null : avatarThumbUrl,
        "base_status": baseStatus == null ? null : baseStatus,
        "exp_lv": expLv == null ? null : expLv,
        "exp_value": expValue == null ? null : expValue,
        "gender": gender == null ? null : gender,
        "vip_lv": vipLv == null ? null : vipLv,
        "vip_value": vipValue == null ? null : vipValue,
        "is_author": isAuthor == null ? null : isAuthor,
        "is_uploader": isUploader == null ? null : isUploader,
        "book_age": bookAge == null ? null : bookAge,
        "category_prefer": categoryPrefer == null
            ? null
            : List<dynamic>.from(categoryPrefer.map((x) => x)),
        "used_decoration": usedDecoration == null
            ? null
            : List<dynamic>.from(usedDecoration.map((x) => x)),
        "rank": rank == null ? null : rank,
        "ctime": ctime == null ? null : ctime.toIso8601String(),
      };
}
