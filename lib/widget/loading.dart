import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width,
        color: Colors.grey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width / 3,
              height: 3,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
              ),
            ),
          ],
        ));
  }
}
