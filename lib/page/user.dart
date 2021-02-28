import 'package:cached_network_image/cached_network_image.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/user.dart';
import 'package:nyax/state/user.dart';
import 'package:url_launcher/url_launcher.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final UserLogic logic = Get.put(UserLogic());
  final UserState state = Get.find<UserLogic>().state;
  bool isMoon = false;
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
          shrinkWrap: true,
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
                                    color: HexColor('#313131').withOpacity(0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5)),
                            TextSpan(
                                text: '\n \n',
                                style: TextStyle(height: 1.0, fontSize: 4)),
                            TextSpan(
                                text:
                                    'Lv${state.readerInfo.value.expLv}\t\t${state.lvInfo.value}\t\t\t\t|\t\t\t\t${state.propInfo.value.restRecommend}推荐票\t\t${state.propInfo.value.restYp}月票\t\t${state.propInfo.value.restTotalBlade}刀片',
                                style: TextStyle(
                                  color: HexColor('#313131').withOpacity(0.8),
                                  fontSize: 12,
                                  height: 1.5,
                                ))
                          ])))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildDataItems([
                      _DataItem(
                        state.trackAmount.value,
                        '阅读',
                      ),
                      _DataItem(
                        state.followingAmount.value,
                        '关注',
                      ),
                      _DataItem(
                        state.followedAmount.value,
                        '粉丝',
                      ),
                    ]),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Divider(
                height: 1,
                color: HexColor('#eeeeee'),
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/ic_menu_wallet.png',
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            '钱包',
                            style: TextStyle(color: HexColor('#333333')),
                          ),
                        )
                      ],
                    ),
                    Obx(() => Text(
                          '${state.propInfo.value.restHlb} 猫饼干',
                          style: TextStyle(
                              color: HexColor('#757575'), fontSize: 12),
                        ))
                  ],
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_finance.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '充值',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () async {
                _launchURL(Uri(
                        scheme: 'https',
                        path: 'www.ciweimao.com/recharge/index')
                    .toString());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
                color: HexColor('#eeeeee'),
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_exp.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '经验',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_foot.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '足迹',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_books_col.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '书单',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
                color: HexColor('#eeeeee'),
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/ic_menu_moon.png',
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            '夜间',
                            style: TextStyle(color: HexColor('#222222')),
                          ),
                        )
                      ],
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(60.0, 19)
                        ..scale(0.24, 0.24),
                      child: DayNightSwitch(
                        value: isMoon,
                        onChanged: (value) {
                          setState(() {
                            isMoon = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  isMoon = !isMoon;
                });
              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_config.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '设置',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/ic_menu_account.png',
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '账号',
                        style: TextStyle(color: HexColor('#333333')),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.toNamed("/login");
                // CwmRouter.pushNoParams("cwm://LoginPage");
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDataItems(List<_DataItem> itemList) {
    return itemList.map((item) {
      return RichText(
          text: TextSpan(children: [
        TextSpan(
            text: item.data,
            style: TextStyle(color: HexColor('#222222'), fontSize: 20)),
        TextSpan(text: '\t'),
        TextSpan(
            text: item.name,
            style: TextStyle(color: HexColor('#757575'), fontSize: 12))
      ]));
    }).toList();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _DataItem {
  String data, name;
  _DataItem(this.data, this.name);
}
