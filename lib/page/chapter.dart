import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyax/logic/chapter.dart';
import 'package:nyax/widget/loading.dart';

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
                if (logic.pages == null) {
                  return Loading();
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    logic.pageController.position.isScrollingNotifier
                        .addListener(logic.pageListener);
                  });
                  return PageView.builder(
                    controller: logic.pageController,
                    itemCount: logic.pages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                        child: logic.getPageWidget(index),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
