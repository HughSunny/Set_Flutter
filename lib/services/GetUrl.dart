
import 'package:set_flutter/services/Api.dart';

class GetUrl {

  static String getShowDocumentUrl(String id) {
    if (id == null) {
      return null;
    }
    var url = '';
    if (Api.BASE_URL != null) {
      url = Api.BASE_URL + '/api/Media/ShowFile/?id=${id}';
    } else {
    url = '/api/Document/ShowDocument?id='+id;
    }

    return url;
  }

  static String getAvatar(String id) {
    return Api.BASE_URL +'/api/Media/ShowFile?id='+id;
  }

  // 获取上传附件地址
  // @param {Number} type  1-resume文件;2-resume头像;3-公司logo;4-Candidate头像;5-user头像;6-公司license

  static String getUploadUrl(type) {
    return Api.BASE_URL +'/api/Media/UploadFile/'+type;
  }

// http://106.14.220.79:8081/api/Media/ShowImage?id=${record.document.id}&targetSize=${}
// targetSize   -1: 图片原尺寸, 0: 32*32的尺寸， 其他：按照targetSize尺寸
  static String getShowImageUrl(String id, {int targetSize = 32}) {
    if (id == null) {
      return null;
    }
    Map<String, String> params = Map();

    params['id'] = id;
    if (targetSize == -1) {
      params['targetSize'] = '0';
    } else {
      params['targetSize'] = '$targetSize';
    }
    String paramStr = getUrlQueryString(params);
    if (Api.BASE_URL != null) {
      return Api.BASE_URL+ '/api/Media/ShowImage'+ paramStr;
    }
    return '/api/Media/ShowImage'+ paramStr;
  }


  ///
  /// 给定url添加 http 或 https
  /// @param {String} url 要处理 url
  /// {Boolean} [isHttps=false] 是否是https
  ///
  static String getHttpUrl(url, {isHttps = false}) {
    RegExp exp = new RegExp("/(http|https):\/\/([\w.]+\/?)\S*/");
    if (exp.hasMatch(url)) {
      return url;
    }
    return 'http${isHttps ? 's' : ''}://${url}';
  }

  // 带 ?
  static String getUrlQueryString( Map<String, dynamic> params){
    String paramStr = '';
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=$value" + "&");
      });
      paramStr = sb.toString();

      paramStr = paramStr.substring(0, paramStr.length - 1);
//      print('参数是$paramStr');
    }
    return paramStr;
  }

}