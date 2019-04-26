import 'dart:async';

import 'package:set_flutter/services/global.dart';
import 'package:set_flutter/utils/TsUtils.dart';
import 'package:set_flutter/utils/net/DioUtil.dart';

class AppRequest {
  static AppRequest instance;

  ///
  static AppRequest getInstance() {
    if (instance == null) {
      instance = new AppRequest();
    }
    return instance;
  }

  static Future<List<dynamic>> requestList(
      String api, Map<String, dynamic> params) async {
    if (!checkPermission()) {
      return Future.error('检查配置');
    }
    List<dynamic> resData =
        await DioUtil.postJson2List(api, params).catchError((errorMsg) {
      if (errorMsg is LogicError) {
        LogicError logicError = errorMsg;
        TsUtils.showShort(logicError.msg);
      } else {
        /// 请求失败 dio异常
        ///
        TsUtils.showShort('网络好像不太好哟~~');
      }
    });
    return resData;
  }

  static Future<Map<String, dynamic>> request(
      String api, Map<String, dynamic> params) async {
    if (!checkPermission()) {
      return Future.error('检查配置');
    }
    Map<String, dynamic> resData =
        await DioUtil.postJson(api, params).catchError((errorMsg) {
          print(errorMsg);
      if (errorMsg is LogicError) {
        LogicError logicError = errorMsg;
        TsUtils.showShort(logicError.msg);
      } else {
        /// 请求失败 dio异常
        TsUtils.showShort('网络好像不太好哟~~');
      }
    });
    return resData;
  }


  static bool checkPermission(){
    return true;
  }


  ///测试网络失败
  static Future<List<dynamic>>  successTest() async{
    var data = {
      'lovGroup': 'EDUCATIONLEVEL',
    };
    List<dynamic> resData = await AppRequest.requestList(GlobalService.GET_LOV_LIST, data);
    return resData;
  }


  ///测试网络失败
  static errorTest() {
    var data = {};
    //      DioUtil.post(GET_LOV_LIST, data);
    DioUtil.postJson2List(GlobalService.SEND_TEST, data)
        .then((List<dynamic> resData) {
      print(resData);
    }).catchError((errorMsg) {
      if (errorMsg is LogicError) {
        LogicError logicError = errorMsg;
        TsUtils.showShort(logicError.msg);
      } else {
        /// 请求失败 dio异常
        ///
        TsUtils.showShort('您的网络好像不太好哟~~');
      }
    });
  }
}
