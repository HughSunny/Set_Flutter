import 'package:set_flutter/model/GlobalData.dart';
import 'package:set_flutter/utils/TsUtils.dart';
import 'package:set_flutter/utils/cache/SpUtils.dart';
import 'package:set_flutter/utils/net/DioUtil.dart';

class GlobalService {

  static const KEY_LOCATION = 'LOCATION';
  static const lovPropsKeys = [
    'EDUCATIONLEVEL',
    'YEARSEXPERIENCE',
    'GENDER',
    'INDUSTRY',
    'EMPLOYMENTTYPE',
    'ARRIVALTIME',
    'CAREERLEVEL',
    'COMPANYTYPE',
    'COMPANYSIZE',
    'EVENTTYPE',
    'SALARYRANGE',
    'PERSONALSTATUS',
    'SKILL',
  ];

  static Future getInitData() async {
    lovPropsKeys.forEach((key) {
      var data = {
        'lovGroup': key,
      };
//      DioUtil.post(GET_LOV_LIST, data);
      print("getInitData  ==> " + key);
      DioUtil.postJson2List(GET_LOV_LIST, data).then((List<dynamic> resData) {
        GlobalData.setLovData(key, resData);
      }).catchError((errorMsg) {
        if (errorMsg is LogicError) {
          LogicError logicError = errorMsg;
          TsUtils.showShort(logicError.msg);
        } else {
          /// 请求失败 dio异常
          TsUtils.showShort('您的网络好像不太好哟~~');
        }
      });
    });
    getGetLocationList();
  }

  static getGetLocationList() async{
    var data = {
      'flag': 1,
    };
    DioUtil.postJson2List(GET_LOCATION_LIST, data).then((List<dynamic> resData) {
      resData.forEach((locationGroup) {
        if (locationGroup['children'] is List) {
          locationGroup['children'].insert(0, {'id':locationGroup['id'], 'name': '不限', 'children':null });
        }
      });
      GlobalData.setLovData(KEY_LOCATION, resData);
    }).catchError((errorMsg) {
      if (errorMsg is LogicError) {
        LogicError logicError = errorMsg;
        TsUtils.showShort(logicError.msg);
      } else {
        /// 请求失败 dio异常
        TsUtils.showShort('您的网络好像不太好哟~~');
      }
    });
  }

  ///测试网络失败
  static errorTest() {
    var data = {};
    DioUtil.postJson2List(SEND_TEST, data).then((List<dynamic> resData) {
      print(resData);
    }).catchError((errorMsg) {
      if (errorMsg is LogicError) {
        LogicError logicError = errorMsg;
        TsUtils.showShort(logicError.msg);
      } else {
        /// 请求失败 dio异常
        ///
        TsUtils.showShort('您的网络好像不太好哟~~~///(^v^)\\\~~~  ');
      }
    });
  }

  static final String GET_LOV_LIST = '/api/Common/GetLovList';

  static final String GET_LOCATION_LIST = '/api/Common/GetLocationList';

  static final String SEND_CAPTCHA = '/api/Common/SendCaptcha';

  static final String SEND_TEST = '/api/recruitee/Candidate/CreateCandidate';
}
