import 'package:flutter/material.dart';

import '../routers/application.dart';
import 'package:set_flutter/pages/login/RegisterPage.dart';
import 'package:set_flutter/pages/login/LoginPage.dart';
import 'package:set_flutter/pages/login/WebLoginPage.dart';
import 'package:set_flutter/test/NewStaticRoute.dart';

class MainPage extends StatefulWidget {
  final title;
  MainPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return _MainPageState(title);
  }
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final title;
  _MainPageState(this.title);

  TabController controller;
  bool isSearch = false;
  String data = '无';
  String appBarTitle = tabData[0]['text'];

  // 生成image组件
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }


  static List tabData = [
    {'text': '业界动态', 'icon': new Icon(Icons.language)},
    {'text': 'WIDGET', 'icon': new Icon(Icons.extension)},
    {'text': '组件收藏', 'icon': new Icon(Icons.star)},
    {'text': '关于手册', 'icon': new Icon(Icons.favorite)}
  ];
  // 底部菜单栏图标数组
  var tabImages;
  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();
    controller = new TabController(
        initialIndex: 0, vsync: this, length: 4); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }

    tabImages = [
      [
        getTabImage('images/ic_nav_news_normal.png'),
        getTabImage('images/ic_nav_news_actived.png')
      ],
      [
        getTabImage('images/ic_nav_tweet_normal.png'),
        getTabImage('images/ic_nav_tweet_actived.png')
      ],
      [
        getTabImage('images/ic_nav_discover_normal.png'),
        getTabImage('images/ic_nav_discover_actived.png')
      ],
      [
        getTabImage('images/ic_nav_my_normal.png'),
        getTabImage('images/ic_nav_my_pressed.png')
      ]
    ];

    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appBarTitle,
            style: new TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new TabBarView(controller: controller, children: <Widget>[
        new NewStaticRoute(),
        new RegisterPage(),
        new WebLoginPage(),
        new LoginPage(),
      ]),
      bottomNavigationBar:


      Material(
        color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
        child: SafeArea(
          child: Container(
            height: 65.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFd0d0d0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(-1.0, -1.0),
                ),
              ],
            ),
            child: TabBar(
              controller: controller,
              indicatorColor: Theme.of(context).primaryColor, //tab标签的下划线颜色
              // labelColor: const Color(0xFF000000),
              indicatorWeight: 3.0,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: const Color(0xFF8E8E8E),
              tabs: <Tab>[
                Tab(text: '业界动态', icon: Icon(Icons.language)),
                Tab(text: '组件', icon: Icon(Icons.extension)),
                Tab(text: '组件收藏', icon: Icon(Icons.star)),
                Tab(text: '关于手册', icon: Icon(Icons.favorite)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }
}