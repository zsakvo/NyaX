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
        child: Obx(() => Text(state.readerInfo.value.readerName)),
      ),
    );
  }
}
