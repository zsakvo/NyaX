import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
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
      body: Container(),
    );
  }
}
