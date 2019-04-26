import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

class TsUtils{
  static showShort(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0x63CA6C),
        textColor: Color(0xffffff),
    );
  }
}