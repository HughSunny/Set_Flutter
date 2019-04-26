import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilTest extends StatelessWidget {

  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('screenHeight = $screenHeight');
    print('设备宽度:${ScreenUtil.screenWidthDp}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
    print( '底部安全区距离:${ScreenUtil.bottomBarHeight}');
    print('状态栏高度:${ScreenUtil.statusBarHeight}px'); //Status bar height , Notch will be higher Unit px
    double height = screenHeight - ScreenUtil.statusBarHeight - ScreenUtil.bottomBarHeight ;

    print('height = $height');

    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('ScreenUtilTest'),
    ),
    body:Container(
      child: Text('ScreenUtilTest'),
    ));
  }
}