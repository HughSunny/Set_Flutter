import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:set_flutter/components/ShowProgress.dart';
import 'package:set_flutter/model//event/LoginEvent.dart';
import 'package:set_flutter/model/GlobalData.dart';
import 'package:set_flutter/pages/JobMainPage.dart';
import 'package:set_flutter/pages/login/RegisterPage.dart';
import 'package:set_flutter/services/Request.dart';
import 'package:set_flutter/services/global.dart';
import 'package:set_flutter/utils/WidgetsUtils.dart';
import 'package:set_flutter/pages/MainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRightPadding = WidgetsUtils.PADDING_LEFT_RIGHT;
  var topBottomPadding = WidgetsUtils.PADDING_TOP_BOTTOM;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "assets/images/logo.png";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  WidgetsUtils widgetsUtils;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    _myClickRequest(AppRequest.successTest().then((data){
//      print('_myClickRequest callBack');
//    }));
  }

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
//        appBar: new AppBar(
//          title: widgetsUtils.getAppBar('登录'),
//          iconTheme: new IconThemeData(color: Colors.white),
//        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Image.asset(
                LOGO,
              ),
              width: widgetsUtils.screenWidth,
              height: 200,
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 40.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userNameController,
                decoration: new InputDecoration(hintText: "请输入用户名"),
                obscureText: false,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userPassController,
                decoration: new InputDecoration(hintText: "请输入用户密码"),
                obscureText: true,
              ),
            ),
            new InkWell(
              child: new Container(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    '没有账号？马上注册',
                    style: hintTips,
                  ),
                  padding: new EdgeInsets.fromLTRB(
                      leftRightPadding, 10.0, leftRightPadding, 0.0)),
              onTap: (() {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new RegisterPage()));
              }),
            ),
            new Container(
              width: 360.0,
              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
              padding: new EdgeInsets.fromLTRB(leftRightPadding, topBottomPadding,
                  leftRightPadding, topBottomPadding),
              child: new Card(
                color: Color(0xFF63CA6C),
                elevation: 6.0,
                child: new FlatButton(
                    onPressed: () {
                      _postLogin(
                          _userNameController.text, _userPassController.text);
                    },
//                onPressed: () => _myClickRequest,
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        '马上登录',
                        style: new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ));
  }

  _postLogin(String userName, String userPassword) {
//    if (userName.isNotEmpty && userPassword.isNotEmpty) {
//      Map<String, String> params = new Map();
//      params['username'] = userName;
//      params['password'] = userPassword;
//      Http.post(Api.USER_LOGIN, params: params, saveCookie: true)
//          .then((result) {
//        SpUtils.map2UserInfo(result).then((userInfoBean) {
//          if (userInfoBean != null) {
//            OsApplication.eventBus.fire(new LoginEvent(userInfoBean.username));
//            SpUtils.saveUserInfo(userInfoBean);
//            Navigator.pop(context);
//          }
//        });
//      });
//    } else {
//      TsUtils.showShort('请输入用户名和密码');
//    }

    GlobalData.initData();
    GlobalService.getInitData();

//    Navigator.popAndPushNamed(context, 'main_page');
//    Navigator.pushNamed(context, 'main_page');
//    Navigator.of(context).pop();


    _myClickRequest(AppRequest.successTest().then((data) {
      print('_myClickRequest callBack' + data.toString());
//      Navigator.pushNamed(context, 'main_page');
    }).whenComplete(() {
      print('whenComplet' );
//      return Navigator.of(context).pushReplacement(new PageRouteBuilder(pageBuilder:
//          (BuildContext context, Animation<double> animation,
//          Animation<double> secondaryAnimation) {
//        print('Navigator.of(context).pushReplacement');
////        return new JobListPage(searchText:"some attrs you like ");
//        return new MainPage("");
//      }));
    }), () {
      ///做回调的操作
      return Navigator.of(context).pushReplacement(new PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        print('Navigator.of(context).pushReplacement');
        //        return new JobListPage(searchText:"some attrs you like ");
        return new JobMainPage("");
      }));
    });

//    testShowDialog();
  }

  testShowDialog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        });
  }

  _myClickRequest<T>(Future<T> request, VoidCallback requestCompleted) {
    print('_myClickRequest');

    return showDialog<Null>(
        context: context,
        barrierDismissible: true, // false表示必须点击按钮才能关闭
//      child: new Center(
//        child: new CircularProgressIndicator(),
//      ),
        child: ShowProgress(request,requestCompleted:requestCompleted) //将网络请求的方法_postData作为参数传递给ShowProgress显示对话框
    );
  }
}

