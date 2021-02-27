import 'package:get/get.dart';
import 'package:nyax/bean/prop_info.dart';
import 'package:nyax/bean/reader_info.dart';

class UserState {
  Rx<ReaderInfo> readerInfo;
  Rx<PropInfo> propInfo;
  RxString trackAmount;
  RxString followingAmount;
  RxString followedAmount;

  UserState() {
    readerInfo = readerInfoFromJson("""
    { 
      "reader_name": "未登录",
      "avatar_url": "https://pic2.zhimg.com/da8e974dc_xl.jpg" 
    }
    """).obs;
    propInfo = propInfoFromJson("""{ 
      "rest_hlb": "0",
      "rest_yp": "0",
      "rest_recommend": "0",
      "rest_total_blade": "0"
    }""").obs;
    trackAmount = "0".obs;
    followingAmount = "0".obs;
    followedAmount = "0".obs;
  }
}
