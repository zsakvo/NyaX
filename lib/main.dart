import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:nyax/global.dart';
import 'package:nyax/page/home.dart';
import 'package:nyax/page/login.dart';

void main() async {
  G.logger = Logger();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    G.logger.d(box.getKeys().toString());
    if (GetPlatform.isAndroid) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.grey[50]);
      FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[50]);
      if (useWhiteForeground(Colors.grey[50])) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    }
    return GetMaterialApp(
        title: 'Flutter Demo',
        enableLog: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: box.hasData('token') ? HomePage() : LoginPage());
  }
}
