import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/logic/explore.dart';
import 'package:nyax/logic/shelf.dart';
import 'package:nyax/logic/user.dart';
import 'package:nyax/page/explore.dart';
import 'package:nyax/page/shelf.dart';
import 'package:nyax/page/user.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _itemList;
  List<Widget> _pages = [Shelf(), Explore(), User()];
  final itemNames = [
    _Item(
      '书架',
      'assets/image/ic_bottom_shelf.png',
      'assets/image/ic_bottom_shelf_free.png',
    ),
    _Item(
      '探索',
      'assets/image/ic_bottom_explore.png',
      'assets/image/ic_bottom_explore_free.png',
    ),
    _Item(
      '我的',
      'assets/image/ic_bottom_user.png',
      'assets/image/ic_bottom_user_free.png',
    ),
  ];
  ShelfLogic shelfLogic = Get.put(ShelfLogic());
  ExploreLogic exploreLogic = Get.put(ExploreLogic());
  UserLogic userLogic = Get.put(UserLogic());
  @override
  void initState() {
    this._initBottomItems();
    _pageController = PageController();
    super.initState();
    shelfLogic.fetchDatas();
    exploreLogic.fetchDatas();
    userLogic.fetchDatas();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[50], //i like transaparent :-)
          systemNavigationBarColor: Colors.grey[50], // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _itemList,
            currentIndex: _currentIndex,
            iconSize: 24,
            // fixedColor: HexColor('#6EB6FF'),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            onTap: (int index) {
              ///这里根据点击的 index 来显示，非 index 的 page 均隐藏
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(
                index,
              );
            },
          ),
        ));
  }

  _initBottomItems() {
    _itemList = itemNames
        .map((item) => BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              child: ColorFiltered(
                child: Image.asset(
                  item.iconFree,
                ),
                colorFilter:
                    ColorFilter.mode(HexColor('#717171'), BlendMode.srcIn),
              ),
            ),
            label: item.name,
            activeIcon: SizedBox(
              width: 24,
              child: ColorFiltered(
                child: Image.asset(
                  item.icon,
                ),
                colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
              ),
            )))
        .toList();
  }
}

class _Item {
  String name, icon, iconFree;
  _Item(this.name, this.icon, this.iconFree);
}
