
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handler.dart';
// 利用 fluro 进行路由管理
class Routes {
  static String root = "/";
  static String widgetDemo = '/widget-demo';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        });
    router.define('/category/error/404', handler: widgetNotFoundHandler);
//    List widgetDemosList = new WidgetDemoList().getDemos();
//    widgetDemosList.forEach((demo) {
//      Handler handler = new Handler(
//          handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//            return demo.buildRouter(context);
//      });
//
//
//      router.define('${demo.routerName}', handler: handler);
//    });
  }
}
