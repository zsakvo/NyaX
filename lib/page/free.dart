import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/free.dart';
import 'package:nyax/widget/book_row.dart';
import 'package:nyax/widget/loading.dart';

class FreePage extends StatelessWidget {
  FreePage({Key key}) : super(key: key);
  final FreeLogic logic = Get.put(FreeLogic());

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
          "免费书籍",
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
      body: GetBuilder<FreeLogic>(
        builder: (logic) {
          if (logic.tabsList == null) {
            return Loading();
          } else {
            return Column(
              children: [
                Container(
                  width: context.width,
                  height: 42,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: HexColor("#9b9b9b"),
                      width: 0.1,
                    ),
                  )),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: (context.width - logic.tabsList.length) / 4,
                            child: InkWell(
                              child: Text(
                                logic.tabsList[index].moduleTitle,
                                style: TextStyle(
                                    fontSize: 14, color: HexColor("#495057")),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed("/extraIdBookList", arguments: {
                              "title": logic.tabsList[index].moduleTitle,
                              "lid": logic.tabsList[index].listId
                            });
                            // CwmRouter.push("cwm://ExtraIdBookListPage", {
                            //   "title": tabs[index].moduleTitle,
                            //   "id": tabs[index].listId
                            // });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 1,
                          child: VerticalDivider(
                            color: HexColor("#313131").withOpacity(0.6),
                            thickness: 0.1,
                          ),
                        );
                      },
                      itemCount: logic.tabsList.length),
                ),
                Flexible(
                    child: Container(
                  child: ListView.builder(
                    itemCount: logic.modulesList.length,
                    itemBuilder: (context, index) {
                      return _buildModule(logic.modulesList[index]);
                    },
                  ),
                ))
                // _buildExplore()
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildModule(module) {
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
                module["title"],
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
