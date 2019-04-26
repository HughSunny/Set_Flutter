
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:set_flutter/pages/MainPage.dart';
/// https://blog.csdn.net/zhangxiangliang2/article/details/76288642
/// 请求带显示dialog的操作
class ShowProgress<T> extends StatefulWidget {
  ShowProgress(this.requestCallback,{this.requestCompleted});
  final Future<T> requestCallback;//这里Null表示回调的时候不指定类型
  final VoidCallback requestCompleted;
  @override
  _ShowProgressState createState() => new _ShowProgressState();
}

class _ShowProgressState extends State<ShowProgress> {
  @override
  initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 10), () {//每隔10ms回调一次
      widget.requestCallback.then((T) {//这里Null表示回调的时候不指定类型
        Navigator.of(context).pop();//所以pop()里面不需要传参,这里关闭对话框并获取回调的值
        if (widget.requestCompleted != null) {
          widget.requestCompleted();
        }
      });
    });
  }
  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}
