import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/user.dart';
import 'package:nyax/state/user.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final UserLogic logic = Get.put(UserLogic());
  final UserState state = Get.find<UserLogic>().state;
  @override
  void initState() {
    super.initState();
    logic.fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: false,
        titleSpacing: 16,
        title: Text(
          "个人中心",
          style: TextStyle(
              color: HexColor('#313131'),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Obx(() => CachedNetworkImage(
                              imageUrl: state
                                      .readerInfo.value.avatarUrl.isNotEmpty
                                  ? state.readerInfo.value.avatarUrl
                                  : "https://pic2.zhimg.com/da8e974dc_xl.jpg",
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    "assets/image/img_ava_default.jpg");
                              },
                              width: 56,
                              height: 56,
                            )),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Obx(() => RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: state.readerInfo.value.readerName,
                                style: TextStyle(
                                    color: HexColor('#222222'),
                                    fontSize: 14,
                                    height: 1.5)),
                            TextSpan(text: '\n'),
                            TextSpan(
                                text:
                                    'Lv${state.readerInfo.value.expLv}\t\t${state.lvInfo.value}\t\t\t\t|\t\t\t\t${state.propInfo.value.restRecommend}推荐票\t\t${state.propInfo.value.restYp}月票\t\t${state.propInfo.value.restTotalBlade}刀片',
                                style: TextStyle(
                                  color: HexColor('#757575'),
                                  fontSize: 11,
                                  height: 1.5,
                                ))
                          ])))
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => Text(state.readerInfo.value.readerName)),
            Obx(() => Text(state.readerInfo.value.avatarUrl)),
            Obx(() => Text(state.trackAmount.value)),
            Obx(() => Text(state.followedAmount.value)),
            Obx(() => Text(state.followingAmount.value))
          ],
        ),
      ),
    );
  }
}
