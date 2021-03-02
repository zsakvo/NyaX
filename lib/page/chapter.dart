import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/chapter.dart';
import 'package:nyax/widget/loading.dart';

class ChapterPage extends StatelessWidget {
  ChapterPage({Key key}) : super(key: key);
  final ChapterLogic logic = Get.put(ChapterLogic(Get.arguments));

  @override
  Widget build(BuildContext context) {
    print(Get.statusBarHeight / window.devicePixelRatio);
    return Material(
      color: Colors.blue[300],
      child: SafeArea(
        child: Stack(
          children: [
            GetBuilder<ChapterLogic>(
              builder: (logic) {
                return logic.pages == null
                    ? Loading()
                    : PageView.builder(
                        itemCount: logic.pages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 24),
                            child:
                                logic.tc.getPageWidget(logic.tc.pages[index]),
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
