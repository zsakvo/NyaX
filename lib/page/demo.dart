import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DemoPage extends StatefulWidget {
  DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  var colors = [
    HexColor("#ef9a9a"),
    HexColor("#f48fb1"),
    HexColor("#ce93d8"),
    HexColor("#b39ddb"),
    HexColor("#9fa8da")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#4db6ac"),
      ),
      body: Container(
        child: PageView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Container(
              color: colors[index],
            );
          },
        ),
      ),
    );
  }
}
