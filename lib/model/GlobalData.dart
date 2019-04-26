import 'package:set_flutter/services/global.dart';
import 'package:set_flutter/utils/cache/SpUtils.dart';

class GlobalData {
  static Map<String, List<dynamic>> lovCacheData = new Map();

  static initData() async {
    GlobalService.lovPropsKeys.forEach((key) {
      SpUtils.getLovData(key).then((data) {
        lovCacheData[key] = data;
      });
    });
    List<dynamic> publishRange = [];
    Map publish1 = new Map();
    publish1['id'] = '1';
    publish1['name'] = '今天';
    publishRange.add(publish1);

    Map publish2 = new Map();
    publish2['id'] = '3';
    publish2['name'] = '三天内';
    publishRange.add(publish2);
    Map publish3 = new Map();
    publish3['id'] = '7';
    publish3['name'] = '一周内';
    publishRange.add(publish3);
    Map publish4 = new Map();
    publish4['id'] = '14';
    publish4['name'] = '两周内';
    publishRange.add(publish4);

    lovCacheData['PUBLISH_RANGE'] = publishRange;
  }

  static setLovData(String key, dynamic value) async {
    lovCacheData[key] = value;
    SpUtils.saveGovData(key, value);
  }


  static const List<dynamic> PUBLISH_RANGE = [
    {
      'id': '1',
      'name': '今天',
    },
    {
      'id': '3',
      'name': '三天内',
    },
    {
      'id': '7',
      'text': '一周内',
    },
    {
      'id': '14',
      'name': '两周内',
    },
  ];
}
