import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:set_flutter/utils/cache/SpUtils.dart';
import 'package:set_flutter/services/Api.dart';

class DioUtil {
  static final String unknownError ="未知异常";
  static final debug = true;
  static final _dio = new Dio(new BaseOptions(
      baseUrl: Api.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: true));

  ///简单的获取数据范例
  static Future get(String url, {Map<String, dynamic> params}) async {
    var response = await _dio.get(url, queryParameters: params);
    print('get请求成功!response.data：${response.data}');
    return response.data;
  }


  ///简单的获取数据范例
  static Future post(String url, Map<String, dynamic> params) async {
    var response = await _dio.post(url, data: params);
    print('post请求成功!response.data：${response.data}');
    return response.data;
  }


  static String token;

  /// requestBody (json格式参数) 方式的 post
  static Future<Map<String, dynamic>> postJson(
      String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalErrorTransform);

  /// (json格式参数)的 post  返回list
  static Future<List<dynamic>> postJson2List(
      String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalErrorTransform);


  static Future<Map<String, dynamic>> getJson<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras).then(logicalErrorTransform);


  static Future<Map<String, dynamic>> getForm<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 表单方式的post
  static Future<Map<String, dynamic>> postForm<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("post", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);


  static Future<Map<String, dynamic>> deleteJson<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("delete", uri, data: body).then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 put
  static Future<Map<String, dynamic>> putJson<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body).then(logicalErrorTransform);

  /// 表单方式的 put
  static Future<Map<String, dynamic>> putForm<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 文件上传  返回json数据为字符串
  static Future<T> putFile<T>(String uri, String filePath) {
    var name =
        filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "multipartFile": new UploadFileInfo(new File(filePath), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    var enToken = token == null ? "" : Uri.encodeFull(token);
    return _dio
        .put<Map<String, dynamic>>("$uri?token=$enToken", data: formData)
        .then(logicalErrorTransform);
  }

  static Future<Response<Map<String, dynamic>>> _httpJson(
      String method, String uri,
      {Map<String, dynamic> data, bool dataIsJson = true}) {
    var enToken = token == null ? "" : Uri.encodeFull(token);

    /// 如果为 get方法，则进行参数拼接
    if (method == "get") {
      dataIsJson = false;
      if (data == null) {
        data = new Map<String, dynamic>();
      }
      data["token"] = token;
    }

    if (debug) {
      print('<net url>------$uri');
      print('<net params>------$data');
    }

    /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
    /// 否则则是表单形式的（拼接在url上）
    Options op;
    if (dataIsJson) {
      op = new Options(contentType: ContentType.parse("application/json"));
    } else {
      op = new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"));
    }

    op.method = method;

    /// 统一带上token
    return _dio.request<Map<String, dynamic>>(
//        method == "get" ? uri : "$uri?token=$enToken",
        uri,
        data: data,
        options: op);
  }

  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<T> logicalErrorTransform<T>(
      Response<Map<String, dynamic>> resp) {
    LogicError error =  new LogicError(-1, unknownError);;
    if (resp.data != null) {
      var success = resp.data["success"];
      if (success) {
        T realData = resp.data["result"];
        return Future.value(realData);
      } else {
        if (debug) {
          print('resp--------$resp');
          print('resp.data--------${resp.data}');
        }
        if (resp.data["message"]) {
          error = new LogicError(resp.data["stateCode"], resp.data["message"]);
        } else {
          error = new LogicError(resp.data["stateCode"], unknownError);
        }
      }
    }
    return Future.error(error);
  }

  ///获取授权token
  static getToken() async {
    String token = await SpUtils.getCookie();
    return token;
  }
}


class LoginInvalidHandler {
  BuildContext currentContext;
  LoginInvalidHandler(this.currentContext);

  Future<Null> loginInvalidHandler(dynamic errorMsg) {
    if (errorMsg != null &&
        errorMsg is LogicError &&
        errorMsg.errorCode == 10000) {
      SpUtils.cleanUserInfo();
      Fluttertoast.showToast(
          msg: '您的登录已过期，请重新登录',
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3);
      /// 进入登录页的路由跳转
      // NavigatorUtils.goPwdLogin(currentContext);
      return Future.error(errorMsg);
    }
    return Future.error(errorMsg);
  }
}

/// 统一异常类
class LogicError {
  int errorCode;
  String msg;

  LogicError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}
