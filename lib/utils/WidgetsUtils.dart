import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:set_flutter/app/StyleConstants.dart';

class WidgetsUtils {
  // 屏幕宽度
  double screenWidth;
  static const double PADDING_LEFT_RIGHT = AppSize.MARGIN_LARGE;
  static const double PADDING_TOP_BOTTOM = AppSize.MARGIN_SMALL;

  WidgetsUtils(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    screenWidth = ScreenUtil.screenWidthDp;
  }

  Widget buildImage(String url, int height){
    return null;
  }

  //根据图片list返回一个9宫格的东西
  List<Widget> initImgGridView(String imgStr) {
    List<Widget> widgetList = [];
    if (imgStr != null && imgStr.length > 0) {
      List<String> imgList = imgStr.split(",");
      List<String> imgUrl = new List<String>();
      for (String s in imgList) {
        if (s.startsWith(
            'https://static.oschina.net/uploads/space/https://oscimg.oschina.net/oscnet')) {
          imgUrl.add(s.substring(
              'https://static.oschina.net/uploads/space/'.length, s.length));
        } else {
          imgUrl.add(s);
        }
      }
      debugPrint('the imgUrl list is ${imgUrl.toString()}');
      List<List<Widget>> rows = [];
      num len = imgUrl.length;
      if (len > 1) {
        for (var row = 0; row < getRow(len); row++) {
          List<Widget> rowArr = [];
          for (var col = 0; col < 3; col++) {
            num index = row * 3 + col;
            double cellWidth = (screenWidth - 100) / 3;
            if (index < len) {
              rowArr.add(new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image.network(
                  imgUrl[index],
                  width: cellWidth,
                  height: cellWidth,
                ),
              ));
            }
          }
          rows.add(rowArr);
        }
        for (var row in rows) {
          widgetList.add(new Row(
            children: row,
          ));
        }
      } else {
        double cellWidth = (screenWidth - 100) / 3;
        widgetList.add(new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Image.network(
                imgUrl[0],
                width: cellWidth,
                height: cellWidth,
              ),
            )
          ],
        ));
      }
    }

    debugPrint('the widgetList is ${widgetList.toString()}');
    return widgetList;
  }

  // 获取行数，n表示图片的张数
  // 如果n取余不为0，则行数为n取整+1，否则n取整就是行数
  int getRow(int n) {
    int a = n % 3; // 取余
    int b = n ~/ 3; // 取整
    if (a != 0) {
      return b + 1;
    }
    return b;
  }


// 获取appBar
  Widget getAppBar(var title) {
    return new Text(title, style: new TextStyle(color: Colors.white));
  }
}
