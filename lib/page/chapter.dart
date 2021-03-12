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
                if (logic.cptMap.isEmpty) {
                  return Loading();
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    logic.pageController.position.isScrollingNotifier
                        .addListener(logic.pageListener);
                  });
                  return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification.depth == 0 &&
                            notification is ScrollEndNotification) {
                          final PageMetrics metrics = notification.metrics;
                          final int currentPage = metrics.page.round();
                          if (currentPage != logic.currentPageIndex) {
                            // _lastReportedPage = currentPage;
                            // _onPageChange(currentPage);
                            logic.getPageWidget(currentPage);
                          }
                        }
                        return false;
                      },
                      child: PageView.builder(
                        controller: logic.pageController,
                        itemCount: logic.allCptNum,
                        itemBuilder: (context, index) {
                          return logic.getPageWidget(index);
                        },
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
