import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:nyax/global.dart';
import 'package:nyax/http/http_request.dart';
import 'package:nyax/route.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  G.logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  await GetStorage.init();
  DioUtil.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    if (GetPlatform.isAndroid) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
      if (useWhiteForeground(Colors.grey[50])) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    }
    return RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
              idleText: "下拉刷新",
              idleIcon: null,
              refreshingText: "正在刷新",
              refreshingIcon: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 1.8),
              ),
              releaseText: "松手刷新",
              releaseIcon: null,
              completeText: "刷新完成",
              completeIcon: null,
            ), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        footerBuilder: () => CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                TextStyle textStyle = TextStyle(color: HexColor('#9E9E9E'));
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载", style: textStyle);
                } else if (mode == LoadStatus.loading) {
                  body = Text("正在加载……", style: textStyle);
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败", style: textStyle);
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松开加载", style: textStyle);
                } else {
                  body = Text("总得有个头吧", style: textStyle);
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ), // 配置默认底部指示器
        headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
        springDescription: SpringDescription(
            stiffness: 170,
            damping: 16,
            mass: 1.9), // 自定义回弹动画,三个属性值意义请查询 flutter api
        maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxUnderScrollExtent: 100, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted:
            true, //这个属性不兼容 PageView 和 TabBarView,如果你特别需要 TabBarView 左右滑动,你需要把它设置为 true
        enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: true, // Viewport 不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: false, // 可以通过惯性滑动触发加载更多
        child: GetMaterialApp(
          title: 'NyaX',
          enableLog: true,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: box.hasData('token') ? HomePage() : LoginPage(),
          initialRoute:
              box.hasData('token') ? RouteConfig.home : RouteConfig.login,
          getPages: RouteConfig.getPages,
        ));
  }
}
