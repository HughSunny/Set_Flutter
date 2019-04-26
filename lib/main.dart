import 'dart:async';

import 'package:flutter/material.dart';
import 'package:set_flutter/app/application.dart';
import 'package:set_flutter/app/translations.dart';
import 'package:set_flutter/test/ButtonTest.dart';
import 'package:set_flutter/test/ContainerTest.dart';
import 'package:set_flutter/test/HtmlWidget.dart';
import 'package:set_flutter/test/NewStaticRoute.dart';
import 'package:set_flutter/pages/MainPage.dart';
import 'package:set_flutter/pages/login/LoginPage.dart';
import 'package:set_flutter/pages/SplashPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:set_flutter/test/ScreenUtilTest.dart';
import 'package:set_flutter/test/TagTest.dart';
import 'package:set_flutter/test/TagsTest.dart';

//void main() => runApp(MyApp());

void collectLog(String line) {
  //收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return null;
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); //手机日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    /// 初始化一个新的Localization Delegate，有了它，当用户选择一种新的工作语言时，可以强制初始化一个新的Translations
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);

    /// 保存这个方法的指针，当用户改变语言时，我们可以调用applic.onLocaleChanged(new Locale('en',''));，通过SetState()我们可以强制App整个刷新
    applic.onLocaleChanged = onLocaleChange;
  }

  /// 改变语言时的应用刷新核心，每次选择一种新的语言时，都会创造一个新的SpecificLocalizationDelegate实例，强制Translations类刷新。
  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // App名字
      title: 'Hugh Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),


      localizationsDelegates: [
        _localeOverrideDelegate, // 注册一个新的delegate
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: applic.supportedLocales(),

      //注册路由表
      routes: {
        "splash":(context) =>SplashPage(),
        "login": (context) => LoginPage(),
        "new_page": (context) => NewStaticRoute(),
        "main_page": (context) => MainPage('111'),
      },
//      home: OfficialDemo(title: 'HughShi Demo Home Page'),
      home: new HtmlWidget(),
    );
  }
}


