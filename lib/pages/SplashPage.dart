import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Image.asset("assets/images/screen.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover),
    );
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

// 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, go2HomePage);
  }

  void go2HomePage() {
    Navigator.of(context).pushReplacementNamed('login');
  }
}
