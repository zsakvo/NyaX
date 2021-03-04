import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyax/logic/chapter.dart';

class ChapterPage extends StatelessWidget {
  ChapterPage({Key key}) : super(key: key);
  final ChapterLogic logic = Get.put(ChapterLogic(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[50],
      child: SafeArea(
        child: Stack(
          children: [
            GetBuilder<ChapterLogic>(
              builder: (logic) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  logic.pageController.position.isScrollingNotifier
                      .addListener(logic.pageListener);
                });
                return PageView.builder(
                  controller: logic.pageController,
                  itemCount: logic.pages.length,
                  itemBuilder: (context, index) {
                    return logic.tc
                        .getPageWidget(logic.pages[index], logic.pages.length);
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
