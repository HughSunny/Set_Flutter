import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/app/translations.dart';
import 'package:set_flutter/pages/job/JobDetailPage.dart';
import 'package:set_flutter/services/GetUrl.dart';
import 'package:set_flutter/utils/Helper.dart';
import 'package:set_flutter/utils/TimeUtil.dart';

typedef Future<void> GetPageData(int page);

///职位列表，带下拉功能
///
///
class JobListView extends StatefulWidget {
  final List<dynamic> listData;
  final int page;
  final bool needTopRefresh;
  final bool loadMore;

  final GetPageData getPageData;

  JobListView(
    this.listData,
    this.loadMore,
    this.getPageData,
    this.page, {
    Key key,
    this.needTopRefresh: true,
  }) : super(key: key);

  @override
  _JobListViewState createState() => new _JobListViewState();
}

class _JobListViewState extends State<JobListView> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool _loadMore = true;

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  // 列表中资讯标题的样式
  TextStyle salaryTextStyle = TextStyle(
      fontSize: AppSize.TEXT_SMALL, color: Color(AppColor.primary_0));

  // 时间文本的样式
  TextStyle subtitleStyle = TextStyle(
      color: const Color(0xFFB5BDC0), fontSize: AppSize.TEXT_SMALL);

  //  作者style
  TextStyle companyStyle = TextStyle(
      color: const Color(AppColor.subTextColor),
      fontSize: AppSize.TEXT_SMALL);

  _buildListView() {
    return EasyRefresh(
      key: _easyRefreshKey,
      autoLoad: true,
      behavior: RefreshBehavior(showTrailing: true, showLeading: true),
      refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: Translations.of(context).text("pullToRefresh"),
          refreshReadyText: Translations.of(context).text("releaseToRefresh"),
          refreshingText: Translations.of(context).text("refreshing") + "...",
          refreshedText: Translations.of(context).text("refreshed"),
          moreInfo: Translations.of(context).text("updateAt"),
          bgColor: Theme.of(context).primaryColor),
      refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadHeight: 50.0,
          loadText: Translations.of(context).text("pushToLoad"),
          loadReadyText: Translations.of(context).text("releaseToLoad"),
          loadingText: Translations.of(context).text("loading"),
          loadedText: Translations.of(context).text("loaded"),
          noMoreText: Translations.of(context).text("noMore"),
          moreInfo: Translations.of(context).text("updateAt"),
          bgColor: Theme.of(context).primaryColor),
      child: //这边不能封装，父组件要进行判断
          ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 0.5,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Container(
              color: Colors.black12,
            ),
          );
        },
        itemBuilder: (context, i) => _renderListRow(i),
        padding: EdgeInsets.all(5.0),
        itemCount: widget.listData.length,
      ),
      onRefresh: widget.needTopRefresh
          ? (() async {
              await widget.getPageData(1);
            })
          : (null),

//          () async {
//        await Future.delayed(const Duration(seconds: 1), () {
//          setState(() {
//            getPageData(1);
//            //刷新数据
//            _easyRefreshKey.currentState.waitState(() {
//              setState(() {
//                _loadMore = true;
//              });
//            });
//          });
//        });
//      },
      loadMore: _loadMore
          ? () async {
              await widget.getPageData(widget.page + 1);
            }
//      async {
//        await Future.delayed(const Duration(seconds: 1), () {
//          if (listTotalSize < 20) {
//            setState(() {
//              listTotalSize = listTotalSize + 10;
//            });
//          } else {
//            _easyRefreshKey.currentState.waitState(() {
//              setState(() {
//                _loadMore = false;
//              });
//            });
//          }
//        });
//      }
          : null,
    );
  }

  // 渲染列表item
  Widget _renderListRow(i) {
    Map itemData = widget.listData[i];
    String salary =
        Helper.formatSalary(itemData['salaryFrom'], itemData['salaryTo']);
    var desc = [];

    if (itemData['location'] != null) {
      desc.addAll(itemData['location'].split('/'));
    }
    if (itemData['experienceYears'] != null) {
      desc.add(itemData['experienceYears']);
    }
    if (itemData['educationLevel'] != null) {
      desc.add(itemData['educationLevel']);
    }

//    标题行
    var titleRow = Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Text(salary, style: salaryTextStyle), //itemData['jobTitle']
        // 标题充满一整行，所以用Expanded组件包裹
        Expanded(
          child: Text(itemData['jobTitle']), //itemData['jobTitle']
        )
      ],
    );
    // 时间这一行包含了作者头像、时间、评论数这几个
    var timeRow = Row(
      children: <Widget>[
        Container(
          child: Text(
            desc.join('|'),
            style: subtitleStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            // 为了让评论数显示在最右侧，所以需要外面的Expanded和这里的MainAxisAlignment.end
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(TimeUtil.getTimeDuration(itemData['publishedOn']),
                  style: subtitleStyle),
            ],
          ),
        )
      ],
    );

    var companyLogo = Padding(
      padding: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
      child: Image.network(
          GetUrl.getShowImageUrl(itemData['logoId'], targetSize: 80),
          width: AppSize.ICON_LARGE,
          height: AppSize.ICON_LARGE),
    );
    var row = Row(
      children: <Widget>[
        companyLogo,
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 6.0),
                  child: titleRow,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        itemData['companyName'],
                        style: companyStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: timeRow,
                )
              ],
            ),
          ),
        ),
      ],
    );
    return InkWell(
      child: row,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return JobDetailPage(itemData);
        }));
      },
    );
  }
}
