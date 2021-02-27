import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
        title: Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  bottom: BorderSide(
                    color: HexColor("#bdc3c7"),
                    width: 0.1,
                  ),
                )),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      //背景
                      color: HexColor("#f2f2f2"),
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      //设置四周边框
                      border: Border.all(
                        width: 1,
                        color: HexColor("#f2f2f2"),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ColorFiltered(
                          child: Image.asset(
                            "assets/image/ic_search_bar_prefix.png",
                            width: 16,
                          ),
                          colorFilter: ColorFilter.mode(
                              HexColor('#919191'), BlendMode.srcIn),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "搜索书籍或作者",
                          style: TextStyle(
                              color: HexColor("#919191"), fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    // CwmRouter.pushNoParams("cwm://SearchPage");
                  },
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  radius: 0.0,
                )),
              ],
            )),
      ),
      body: Container(),
    );
  }
}
