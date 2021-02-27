// To parse this JSON data, do
//
//     final propInfo = propInfoFromJson(jsonString);

import 'dart:convert';

PropInfo propInfoFromJson(String str) => PropInfo.fromJson(json.decode(str));

String propInfoToJson(PropInfo data) => json.encode(data.toJson());

class PropInfo {
  PropInfo({
    this.restGiftHlb,
    this.restHlb,
    this.restYp,
    this.restRecommend,
    this.restTotalBlade,
    this.restMonthBlade,
    this.restTotal100,
    this.restTotal588,
    this.restTotal1688,
    this.restTotal5000,
    this.restTotal10000,
    this.restTotal100000,
    this.restTotal50000,
    this.restTotal160000,
  });

  String restGiftHlb;
  String restHlb;
  String restYp;
  String restRecommend;
  String restTotalBlade;
  String restMonthBlade;
  String restTotal100;
  String restTotal588;
  String restTotal1688;
  String restTotal5000;
  String restTotal10000;
  String restTotal100000;
  String restTotal50000;
  String restTotal160000;

  factory PropInfo.fromJson(Map<String, dynamic> json) => PropInfo(
        restGiftHlb:
            json["rest_gift_hlb"] == null ? null : json["rest_gift_hlb"],
        restHlb: json["rest_hlb"] == null ? null : json["rest_hlb"],
        restYp: json["rest_yp"] == null ? null : json["rest_yp"],
        restRecommend:
            json["rest_recommend"] == null ? null : json["rest_recommend"],
        restTotalBlade:
            json["rest_total_blade"] == null ? null : json["rest_total_blade"],
        restMonthBlade:
            json["rest_month_blade"] == null ? null : json["rest_month_blade"],
        restTotal100:
            json["rest_total_100"] == null ? null : json["rest_total_100"],
        restTotal588:
            json["rest_total_588"] == null ? null : json["rest_total_588"],
        restTotal1688:
            json["rest_total_1688"] == null ? null : json["rest_total_1688"],
        restTotal5000:
            json["rest_total_5000"] == null ? null : json["rest_total_5000"],
        restTotal10000:
            json["rest_total_10000"] == null ? null : json["rest_total_10000"],
        restTotal100000: json["rest_total_100000"] == null
            ? null
            : json["rest_total_100000"],
        restTotal50000:
            json["rest_total_50000"] == null ? null : json["rest_total_50000"],
        restTotal160000: json["rest_total_160000"] == null
            ? null
            : json["rest_total_160000"],
      );

  Map<String, dynamic> toJson() => {
        "rest_gift_hlb": restGiftHlb == null ? null : restGiftHlb,
        "rest_hlb": restHlb == null ? null : restHlb,
        "rest_yp": restYp == null ? null : restYp,
        "rest_recommend": restRecommend == null ? null : restRecommend,
        "rest_total_blade": restTotalBlade == null ? null : restTotalBlade,
        "rest_month_blade": restMonthBlade == null ? null : restMonthBlade,
        "rest_total_100": restTotal100 == null ? null : restTotal100,
        "rest_total_588": restTotal588 == null ? null : restTotal588,
        "rest_total_1688": restTotal1688 == null ? null : restTotal1688,
        "rest_total_5000": restTotal5000 == null ? null : restTotal5000,
        "rest_total_10000": restTotal10000 == null ? null : restTotal10000,
        "rest_total_100000": restTotal100000 == null ? null : restTotal100000,
        "rest_total_50000": restTotal50000 == null ? null : restTotal50000,
        "rest_total_160000": restTotal160000 == null ? null : restTotal160000,
      };
}
