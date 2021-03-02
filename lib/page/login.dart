import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nyax/http/api.dart';

import '../global.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool readOnly = false;
  @override
  void initState() {
    if (GetPlatform.isAndroid) {
      FlutterStatusbarcolor.setNavigationBarColor(HexColor("#eeeeee"));
      if (useWhiteForeground(HexColor("#eeeeee"))) {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: context.height / 5,
                  // ),
                  Text(
                    "用户登录",
                    style: TextStyle(
                        color: HexColor("#313131"),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  TextField(
                    controller: nameController,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      labelText: "name",
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      labelText: "password",
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '登陆即代表您已接受',
                          style: TextStyle(
                              fontSize: 12, color: HexColor('#717171'))),
                      TextSpan(
                          text: '《刺猬猫用户服务协议》',
                          style: TextStyle(
                              fontSize: 12, color: HexColor('#333333'))),
                      TextSpan(
                          text: '和',
                          style: TextStyle(
                              fontSize: 12, color: HexColor('#717171'))),
                      TextSpan(
                          text: '《刺猬猫隐私政策》',
                          style: TextStyle(
                              fontSize: 12, color: HexColor('#333333'))),
                    ]),
                  ),
                  SizedBox(
                    height: context.height / 4,
                  ),
                ],
              )),
          Positioned(
            child: Container(
              color: HexColor("#eeeeee"),
              height: 72,
              width: context.width,
            ),
            bottom: 0,
            left: 0,
          ),
          Positioned(
            child: InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: Container(
                width: 64,
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                    color: HexColor("#91d5ff"),
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                child: readOnly
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[50]),
                      )
                    : ColorFiltered(
                        child: Image.asset("assets/image/ic_fab_login.png"),
                        colorFilter:
                            ColorFilter.mode(Colors.grey[50], BlendMode.srcIn),
                      ),
              ),
              onTap: () => _login(),
            ),
            bottom: 40,
            right: 40,
          )
        ],
      ),
    );
  }

  _login() async {
    if (readOnly) return;
    String name = nameController.value.text;
    String password = passwordController.value.text;
    if (name.isEmpty || password.isEmpty) {
      Get.snackbar("错误", "用户名或密码不能为空",
          duration: Duration(milliseconds: 1200),
          animationDuration: Duration(milliseconds: 500),
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16));
      return;
    }
    setState(() {
      readOnly = true;
    });
    var res = await API.login(name: name, pwd: password);
    if (res['success']) {
      var token = res['data']['login_token'];
      var account = res['data']['reader_info']['account'];
      var box = GetStorage();
      box.write('token', token);
      box.write('account', account);
      G.dioMixIn = {
        "app_version": G.appVersion,
        "device_token": G.deviceToken,
        "login_token": token,
        "account": account
      };
      Get.offAllNamed("/");
    }
    setState(() {
      readOnly = false;
    });
    G.logger.d(res);
  }
}

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     if (GetPlatform.isAndroid) {
//       FlutterStatusbarcolor.setNavigationBarColor(HexColor("#eeeeee"));
//       if (useWhiteForeground(HexColor("#eeeeee"))) {
//         FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
//       } else {
//         FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
//       }
//     }
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.light,
//         elevation: 0,
//         backgroundColor: Colors.grey[50],
//         // leading: IconButton(
//         //   icon: Icon(
//         //     Icons.arrow_back_sharp,
//         //     color: HexColor("#313131"),
//         //   ),
//         //   onPressed: () {},
//         // ),
//         titleSpacing: 0,
//       ),
//       body: Stack(
//         children: [
//           Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // SizedBox(
//                   //   height: context.height / 5,
//                   // ),
//                   Text(
//                     "用户登录",
//                     style: TextStyle(
//                         color: HexColor("#313131"),
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 48,
//                   ),
//                   TextField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: "name",
//                       contentPadding: EdgeInsets.only(top: 0, bottom: 0),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   TextField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       labelText: "password",
//                       contentPadding: EdgeInsets.only(top: 0, bottom: 0),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 32,
//                   ),
//                   RichText(
//                     text: TextSpan(children: <TextSpan>[
//                       TextSpan(
//                           text: '登陆即代表您已接受',
//                           style: TextStyle(
//                               fontSize: 12, color: HexColor('#717171'))),
//                       TextSpan(
//                           text: '《刺猬猫用户服务协议》',
//                           style: TextStyle(
//                               fontSize: 12, color: HexColor('#333333'))),
//                       TextSpan(
//                           text: '和',
//                           style: TextStyle(
//                               fontSize: 12, color: HexColor('#717171'))),
//                       TextSpan(
//                           text: '《刺猬猫隐私政策》',
//                           style: TextStyle(
//                               fontSize: 12, color: HexColor('#333333'))),
//                     ]),
//                   ),
//                   SizedBox(
//                     height: context.height / 4,
//                   ),
//                 ],
//               )),
//           Positioned(
//             child: Container(
//               color: HexColor("#eeeeee"),
//               height: 72,
//               width: context.width,
//             ),
//             bottom: 0,
//             left: 0,
//           ),
//           Positioned(
//             child: InkWell(
//               hoverColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               radius: 0.0,
//               child: Container(
//                 width: 64,
//                 height: 64,
//                 padding: EdgeInsets.symmetric(horizontal: 18),
//                 decoration: BoxDecoration(
//                     color: HexColor("#91d5ff"),
//                     borderRadius: BorderRadius.all(Radius.circular(14.0))),
//                 child: ColorFiltered(
//                   child: Image.asset("assets/image/ic_fab_login.png"),
//                   colorFilter:
//                       ColorFilter.mode(Colors.grey[50], BlendMode.srcIn),
//                 ),
//               ),
//               onTap: () {
//                 // Get.defaultDialog(
//                 //     barrierDismissible: true,
//                 //     title: "",
//                 //     titleStyle: TextStyle(
//                 //         color: HexColor("#313131"),
//                 //         fontSize: 0,
//                 //         fontWeight: FontWeight.bold),
//                 //     content: CircularProgressIndicator(),
//                 //     radius: 2.0);

//                 // if (GetPlatform.isAndroid) {
//                 //   FlutterStatusbarcolor.setNavigationBarColor(
//                 //       HexColor("#DADADA"));
//                 //   if (useWhiteForeground(Colors.white.withOpacity(0.7))) {
//                 //     FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
//                 //   } else {
//                 //     FlutterStatusbarcolor.setNavigationBarWhiteForeground(
//                 //         false);
//                 //   }
//                 // }
//                 // Get.dialog(Material(
//                 //     color: Colors.white.withOpacity(0.7),
//                 //     child: Center(
//                 //       child: SizedBox(
//                 //         width: 42,
//                 //         height: 42,
//                 //         child: CircularProgressIndicator(
//                 //           strokeWidth: 3,
//                 //         ),
//                 //       ),
//                 //     )));
//                 G.logger.d(nameController.value.text +
//                     "\n" +
//                     passwordController.value.text);
//               },
//             ),
//             bottom: 40,
//             right: 40,
//           )
//         ],
//       ),
//     );
//   }
// }
