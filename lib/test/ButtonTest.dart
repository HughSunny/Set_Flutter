import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('ButtonUtil'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text("BoxDecoration"),
                ),
              ),
              RaisedButton(
                onPressed: pressedBtn(context),
                color: Color(0xFF82B1FF),
                child: Text("RaisedButton"),
                disabledColor: Colors.red,
                highlightColor: Colors.grey,
                // 按下的背景色
                splashColor: Colors.green,
                // 水波纹颜色
//                colorBrightness: Brightness.light,
              ),
              FlatButton(
                  child: Text("FlatButton"),
                  onPressed: pressedBtn(context),
                  textTheme: ButtonTextTheme.normal,
                  textColor: Colors.yellow,
                  disabledTextColor: Colors.red,
                  disabledColor: Colors.grey,
                  highlightColor: Colors.grey,
                  // 按下的背景色
                  splashColor: Colors.transparent,
                  // 水波纹颜色
//                  colorBrightness: Brightness.light,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                          color: Color(0xFFF9F3FF),
                          style: BorderStyle.solid,
                          width: 2)),
                  clipBehavior: Clip.antiAlias,
                  materialTapTargetSize: MaterialTapTargetSize.padded),
              OutlineButton(
                child: Text("OutlineButton111"),
                onPressed: pressedBtn(context),
//                            textTheme: ButtonTextTheme.accent,
                textColor: Colors.grey,
                //      disabledColor: Colors.grey,
                //      elevation: 10,
                //      disabledElevation: 10,
                padding: EdgeInsets.all(10),
                color: Colors.grey,
                //       RaisedButton 才起效
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(
                        color: Colors.red, style: BorderStyle.solid, width: 2)),
                  borderSide:BorderSide(color: Theme.of(context).primaryColor)
//                            clipBehavior: Clip.antiAlias,
              ),
              OutlineButton.icon(
                icon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                label: Text("OutlineButton.icon"),
                onPressed: pressedBtn(context),
//      onHighlightChanged: onHighlightChanged,
                textTheme: ButtonTextTheme.normal,
                textColor: Colors.yellow,
                disabledTextColor: Colors.red,
                color: Color(0xFF82B1FF),
//      disabledColor: Colors.grey,
                highlightColor: Colors.red,
                // 按下的背景色
                splashColor: Colors.green,
                // 水波纹颜色
//      colorBrightness: Brightness.light,   // 主题
//      elevation: 10,
                highlightElevation: 10,
//      disabledElevation: 10,
                padding: EdgeInsets.all(10),
                // RaisedButton 才起效
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                clipBehavior: Clip.antiAlias,
//      materialTapTargetSize: MaterialTapTargetSize.padded,
//      animationDuration: Duration(seconds:1),
//      minWidth: 200,
//      height: 50,
              ),
              getCupertinoButton(context),
              Container(
                height: 100,
                child: Text("text 11"),
              ),
              Text("text 11"),
              Text("text 11"),
              Text("text 11"),
              Text("text 11"),
            ],
          ),
        ));
  }

  Widget getCupertinoButton(BuildContext context) {
    return CupertinoButton(
      child: Text("CupertinoButton"),
      onPressed: pressedBtn(context),
      color: Colors.blue,
      disabledColor: Colors.grey,
      padding: EdgeInsets.all(5),
      minSize: 50,
      pressedOpacity: 0.8,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }

  VoidCallback pressedBtn(BuildContext context) {
    return () {
      Fluttertoast.showToast(
          msg: '1111',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
    };
  }
}
