import 'package:flutter/material.dart';
import 'package:set_flutter/components/banner/BannerView.dart';

//BannerView 测试
class NewStaticRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: buildBanner(),
    );
  }

  Widget buildBanner() {
    return new Container(
        alignment: Alignment.center,
        height: 200.0,
        child: new BannerView(
          data: <Widget>[
            buildImage("assets/images/food01.jpeg"),
            buildImage("assets/images/ic_nav_my_pressed.png"),
            buildImage("assets/images/ic_nav_my_pressed.png"),
            buildImage("assets/images/ic_nav_my_pressed.png"),
          ],
        ));
  }

  Widget buildImage(String s) {
    return new Image.asset(s);
  }
}
