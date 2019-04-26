//容器测试

import 'package:flutter/material.dart';
import 'dart:math' as math;

class ContainerTest extends StatelessWidget {
  ContainerTest({@required this.index, @required this.onPress});

  final index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("ContainerTest1"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.orange[700]]), //背景渐变
                  borderRadius: BorderRadius.circular(3.0), //3像素圆角
                  boxShadow: [
                    //阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            DecoratedBox(
              decoration:BoxDecoration(color: Colors.red),
              //默认原点为左上角，左移20像素，向上平移5像素
              child: Transform.translate(offset: Offset(-5.0, -5.0),
                child: Text("Hello world11"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green),
              child: Transform.rotate(
                //旋转90度
                angle:math.pi/2 ,
                child: Text("Hello world"),
              ),
            )

          ])),
    );
  }
}
