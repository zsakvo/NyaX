import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/discount.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:nyax/widget/loading.dart';

class DiscountPage extends StatelessWidget {
  DiscountPage({Key key}) : super(key: key);
  final DiscountLogic logic = Get.put(DiscountLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          radius: 0.0,
          child: Container(
            width: 56,
            height: 56,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Image.asset("assets/image/ic_toolbar_left.png"),
          ),
          onTap: () {
            print("on tap toolbar menu");
            Navigator.pop(context);
          },
        ),
        title: Text(
          "限时折扣",
          style: TextStyle(
              fontSize: 16,
              color: HexColor("#313131"),
              fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
            child: Container(
              color: HexColor("#bdc3c7"),
              height: 0.1,
            ),
            preferredSize: Size.fromHeight(0.1)),
      ),
      body: GetBuilder<DiscountLogic>(
        builder: (logic) {
          if (logic.list == null) {
            return Loading();
          } else {
            return ListView.builder(
              itemCount: logic.list.length,
              itemBuilder: (context, index) {
                return _buildModule(logic.list[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildModule(module) {
    String title = module["title"];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: HexColor("#616b75")),
              ),
            ],
          ),
        ),
        ...List.from(module["list"]).map((m) {
          return BookRow(m);
        }).toList(),
      ],
    );
  }
}
