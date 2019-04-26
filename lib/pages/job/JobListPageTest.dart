import 'package:flutter/material.dart';
import 'package:set_flutter/components/SearchInput.dart';
import 'package:set_flutter/model/job_item_entity.dart';
import 'package:set_flutter/model/job_search_entity.dart';

class JobListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JobListPageState();
  }
}

class _JobListPageState extends State<JobListPage>
    with SingleTickerProviderStateMixin {
  bool isShow = false;
  AnimationController controller;//动画控制器

  Animation<EdgeInsets> movement;
  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    movement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: -100.0),
      end: EdgeInsets.only(top: 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.2,
          0.375,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )..addListener((){
      setState(() {

      });
    })
    ..addStatusListener((AnimationStatus status){
      print(status);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();

  }

  void onSearchItemTap(JobSearchEntity job, BuildContext context) {
//    Application.router.navigateTo(context, "$targetRouter");
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
//        List<JobBean> list = await widgetControl.search(value);
        List<JobSearchEntity> list = List();
        list.add(JobSearchEntity('java', '', '', 'google'));
        return list
            .map((item) => new MaterialSearchResult<String>(
                  value: item.jobTitle,
                  text: item.jobTitle,
                  onTap: () {
                    onSearchItemTap(item, context);
                  },
                ))
            .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
  }

  _generateSimpleDialog() {
    return SimpleDialog(
//      title: Text('simple dialog title'),
      children: <Widget>[
        Container(
          height: 100,
          child: Text('这里填写内容'),
        ),
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确认'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future _startAnimation() async {
    try {
      await controller.repeat();
    } on TickerCanceled{
      print('Animation Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    int padding = (movement.value != null)?movement.value:0;
    return new Scaffold(
      appBar: new AppBar(title: buildSearchInput(context)),
      body: Column(
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("职位列表"),
          RaisedButton(
            child: Text('show dialog'),
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
              _startAnimation();
//              showDialog(
//                  context: context, builder: (_) => _generateSimpleDialog());
            },
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Container(
                    child: new ListView.builder(
                      padding: new EdgeInsets.all(5.0),
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return new Text("text $index");
                      },
                    ),
                    color: Colors.blueGrey,
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Offstage(
                        offstage: !isShow,
                        child: Container(
                          child: Text("弹出框",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                        )),
                  ),
//                  Positioned(
//                      left: 0,
//                      right: 0,
//                      top: 0,
//                      bottom: 1,
//                      child: Container(
//                        child: Text("弹出框",
//                            style: TextStyle(color: Colors.white)),
//                        color: Colors.red,
//                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
