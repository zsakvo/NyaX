import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/global.dart';
import 'package:nyax/logic/chapter.dart';
import 'package:nyax/widget/disallow_glow.dart';

class ChapterPage extends StatefulWidget {
  ChapterPage({Key key}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage>
    with TickerProviderStateMixin {
  final ChapterLogic logic = Get.put(ChapterLogic(Get.arguments));
  final double screenWidth = Get.context.width;
  bool _showBars = false;
  Widget _subBar;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  //顶栏&底栏动画与控制器
  AnimationController _controllerBottomBar;
  Animation<Offset> _offsetAnimationBottomBar;
  AnimationController _controllerTopBar;
  Animation<Offset> _offsetAnimationTopBar;

  @override
  void initState() {
    super.initState();
    initBars();
  }

  initBars() {
    _subBar = _renderBottomInfoBar();
    _controllerTopBar = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _offsetAnimationTopBar = Tween<Offset>(
      begin: Offset(0, -2.0),
      end: Offset.zero,
    ).animate(_controllerTopBar);
    _controllerBottomBar = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _offsetAnimationBottomBar = Tween<Offset>(
      begin: Offset(0, 2.0),
      end: Offset.zero,
    ).animate(_controllerBottomBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<ChapterLogic>(
              builder: (logic) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  logic.pageController.position.isScrollingNotifier
                      .addListener(logic.pageListener);
                  if (logic.catalogController != null) {
                    logic.catalogController.addListener(logic.catalogListener);
                  }
                });
                return GestureDetector(
                  child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification.depth == 0 &&
                            notification is ScrollEndNotification) {}
                        return false;
                      },
                      child: PageView.builder(
                        controller: logic.pageController,
                        itemCount: logic.pages.length,
                        itemBuilder: (context, index) {
                          return logic.pages[index];
                        },
                      )),
                  onTap: _onTap,
                  onTapUp: _onTapUp,
                );
              },
            ),
            logic.pages.isNotEmpty
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SlideTransition(
                      position: _offsetAnimationTopBar,
                      child: _renderTopBar(),
                    ),
                  )
                : SizedBox.shrink(),
            logic.pages.isNotEmpty
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: SlideTransition(
                        position: _offsetAnimationBottomBar,
                        child: _renderBottomBar()),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
      drawer: GetBuilder<ChapterLogic>(
        builder: (logic) {
          return Container(
            width: 380,
            child: Drawer(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                color: Colors.grey[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 0, bottom: 14),
                      width: double.infinity,
                      child: Text(
                        "目录",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor("#313131"),
                            fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: HexColor("#313131").withOpacity(0.3),
                                  width: 0.2))),
                    ),
                    Flexible(
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: ListView.builder(
                              controller: logic.catalogController,
                              itemCount: logic.chapterList.length,
                              itemExtent: 46.0,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Padding(
                                    child: InkWell(
                                      child: Text(
                                        logic.chapterList[index]
                                            ['chapter_title'],
                                        style: TextStyle(
                                            color: logic.currentChapterIndex ==
                                                    index
                                                ? Colors.blue
                                                : HexColor("#313131")
                                                    .withOpacity(0.7),
                                            fontSize: 16,
                                            height: 1.5),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        // logic.catalogController.jumpTo(index * 46.0);
                                        logic.jumpChapter(index);
                                      },
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                );
                              },
                            ))),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          logic.sliderValDragHandler(details.delta.dx);
                        },
                        child: Container(
                          height: 18,
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                          decoration: BoxDecoration(
                              color: HexColor("#2196f3").withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Row(
                            children: [
                              Container(
                                width: logic.sliderVal,
                                height: 12,
                                constraints:
                                    BoxConstraints(minWidth: 12, maxWidth: 346),
                                decoration: BoxDecoration(
                                    color: HexColor("#2196f3"),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTap() {
    // G.logger.d("点击了屏幕");
  }

  void _onTapUp(TapUpDetails details) {
    double dx = details.localPosition.dx;
    //判断点击位置
    if (screenWidth / 3 <= dx && dx <= (2 * screenWidth) / 3) {
      G.logger.d("应该呼出菜单");
      switchBars();
    } else if (dx < screenWidth / 3) {
      logic.pageController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else if (dx > (2 * screenWidth) / 3) {
      logic.pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  switchBars() {
    if (!_showBars) {
      // _subBar = _renderBottomInfoBar();
      setState(() {});
      _controllerTopBar.forward();
      _controllerBottomBar.forward();
    } else {
      _controllerTopBar.reverse();
      _controllerBottomBar.reverse();
    }
    _showBars = !_showBars;
  }

  Widget _renderTopBar() {
    return Container(
      height: 52,
      width: screenWidth,
      color: HexColor("#eddd9e"),
      child: Row(
        children: [
          InkWell(
            child: Container(
              width: 52,
              height: 52,
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Image.asset("assets/image/ic_toolbar_left.png"),
            ),
            onTap: () {
              Get.back();
            },
          ),
          Text(
            logic.book.bookName,
            style: TextStyle(fontSize: 16, color: HexColor("#333333")),
          )
        ],
      ),
    );
  }

  Widget _renderBottomBar() {
    return Container(
      // height: 106 + 160.0 + 120.0,
      width: screenWidth,
      color: HexColor('#eddd9e'),
      child: Column(
        children: [
          // _renderBottomInfoBar(),
          // _renderBottomFontBar(),
          // _renderBottomSettingsBar(),
          _subBar,
          Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("assets/image/ic_readbar_catalog.png"),
                  ),
                  onTap: () {
                    // _bookChapterModel.initSliderVal();
                    switchBars();
                    G.logger.d(logic.catalogController.hasClients);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (logic.catalogController.hasClients) {
                        logic.catalogController
                            .jumpTo(logic.currentChapterIndex * 46.0);
                      }
                    });
                    logic.refreshCatalogSlider();
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                InkWell(
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("assets/image/ic_readbar_label.png"),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("assets/image/ic_readbar_font.png"),
                  ),
                  onTap: () {
                    // this._subBar = _renderBottomFontBar();
                    setState(() {});
                  },
                ),
                InkWell(
                  child: Container(
                    width: 56,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("assets/image/ic_readbar_config.png"),
                  ),
                  onTap: () {
                    // this._subBar = _renderBottomSettingsBar();
                    setState(() {});
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _renderBottomInfoBar() {
    return GetBuilder<ChapterLogic>(
      builder: (logic) {
        return Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: HexColor("#595959"), width: 0.1))),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Image.asset("assets/image/ic_readbar_read.png"),
              ),
              Text(
                "已读 " + logic.getReadPercent,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.3),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              InkWell(
                child: Container(
                  width: 42,
                  height: 42,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Image.asset("assets/image/ic_readbar_previous.png"),
                ),
                onTap: () {
                  if (logic.currentChapterIndex == 0) return;
                  logic.jumpChapter(logic.currentChapterIndex - 1);
                },
              ),
              InkWell(
                child: Container(
                  width: 42,
                  height: 42,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Image.asset("assets/image/ic_readbar_refresh.png"),
                ),
                onTap: () {
                  logic.jumpChapter(logic.currentChapterIndex);
                },
              ),
              InkWell(
                child: Container(
                  width: 42,
                  height: 42,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Image.asset("assets/image/ic_readbar_next.png"),
                ),
                onTap: () {
                  if (logic.currentChapterIndex == logic.chapterList.length - 1)
                    return;
                  logic.jumpChapter(logic.currentChapterIndex + 1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
