import 'package:flutter/material.dart';

class AppSize {
  static const double TEXT_HUGH = 23.0;
  static const double TEXT_LARGE = 19.0;
  static const double TEXT_NORMAL = 16.0;
  static const double TEXT_SMALL = 13.0;

  static const double MARGIN_COMMON = 10.0;
  static const double MARGIN_SMALL = 5.0;
  static const double MARGIN_LARGE = 20.0;

  static const double ICON_LARGE = 60.0;
  static const double ICON_NORMAL = 30.0;
  static const double ICON_SMALL = 18.0;

  static const double ROW_HEIGHT = 40.0;
}

//颜色配置
class AppColor {
  static const int white = 0xFFFFFFFF;
  static const int black = 0xFF000000;

  static const int mainTextColor = 0xFF121917;
  static const int subTextColor = 0xFF333333;
  static const int lightText= 0xFF959595;

  static const int background = 0xFFEEEEEE;
  static const int primary_0 = 0xFFFcb233;
  static const int primary_1 = 0xFFd1870f;
}

//文本设置
class AppText {
  static const title = TextStyle(
    color: Color(AppColor.mainTextColor),
    fontSize: AppSize.TEXT_LARGE,
    fontWeight: FontWeight.w400,
  );

  static const mainText = TextStyle(
    color: Color(AppColor.mainTextColor),
    fontSize: AppSize.TEXT_NORMAL,
  );

  static const middleSubText = TextStyle(
    color: Color(AppColor.subTextColor),
    fontSize: AppSize.TEXT_NORMAL,
  );
}
