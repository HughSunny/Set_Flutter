import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:set_flutter/app/translations.dart';
import 'package:set_flutter/components/SearchInput.dart';
import 'package:set_flutter/model/job_item_entity.dart';
import 'package:set_flutter/model/job_search_entity.dart';
import 'package:set_flutter/pages/job/JobDetailPage.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:set_flutter/pages/job/JobListPage.dart';
import 'package:set_flutter/services/GetUrl.dart';
import 'package:set_flutter/services/Request.dart';
import 'package:set_flutter/services/job.dart';
import 'package:set_flutter/utils/Helper.dart';
import 'package:set_flutter/utils/TimeUtil.dart';

class JobPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JobPageState();
  }
}

class _JobPageState extends State<JobPage> with SingleTickerProviderStateMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  bool _loadMore = true;
  List<dynamic> _jobList = [];
  int _page = 1;
  int _pageSize = 10;
  String _keywords = '';

  @override
  void initState() {
    super.initState();
    getPageData(_page, pageSize: 10);
  }

  getPageData(int page, {int pageSize = 0, String keywords}) {
    var queryParam = {
      'page': page,
      'pageSize': pageSize != 0 ? pageSize : _pageSize,
      'keywords': keywords != null ? keywords : _keywords,
    };
    this.setState(() {
      _pageSize = queryParam['pageSize'];
      _keywords = queryParam['keywords'];
    });

    AppRequest.request(JobService.SEARCH_JOB_LIST, queryParam).then((data) {
      print('_myClickRequest callBack' + data.toString());
      if (data == null) {
        return;
      }
      int totalCount = data['totalCount'];
      int totalPages = data['totalPages'];
      if (page == 1) {
        _jobList.clear();
      }
      _jobList.addAll(data['dataList']);
      bool more = (page * _pageSize <= totalCount);
      this.setState(() {
        _page = page;
        _loadMore = more;
      });
    });
  }

  Future getFuturePageData(int page, {int pageSize = 0, String keywords}) async{
    var queryParam = {
      'page': page,
      'pageSize': pageSize != 0 ? pageSize : _pageSize,
      'keywords': keywords != null ? keywords : _keywords,
    };
    this.setState(() {
      _pageSize = queryParam['pageSize'];
      _keywords = queryParam['keywords'];
    });

    return AppRequest.request(JobService.SEARCH_JOB_LIST, queryParam).then((data) {
      print('_myClickRequest callBack' + data.toString());
      if (data == null) {
        return;
      }
      int totalCount = data['totalCount'];
      int totalPages = data['totalPages'];
      if (page == 1) {
        _jobList.clear();
      }
      _jobList.addAll(data['dataList']);
      bool more = (page * _pageSize <= totalCount);
      this.setState(() {
        _page = page;
        _loadMore = more;
      });
    });
  }

  void onSearchItemTap(JobSearchEntity job, BuildContext context) {
//    Application.router.navigateTo(context, "$targetRouter");
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JobListPage(searchText: job.jobTitle);
    }));
  }

  Widget buildSearchInput(BuildContext context) {
    return SearchInput((value) async {
      if (value != '') {
//        List<JobBean> list = await widgetControl.search(value);
        List<JobSearchEntity> list = List();
        list.add(JobSearchEntity(value.toString() + '-f', '', '','google'));
        list.add(JobSearchEntity(value.toString() + '-find', '', '', 'google'));
        return list
            .map((item) => MaterialSearchResult<String>(
                  value: item.jobTitle,
                  text: item.jobTitle,
                  icon: Icons.search,
                  onTap: () {
                    onSearchItemTap(item, context);
                  },
                ))
            .toList();
      } else {
        return null;
      }
    }, (value) {}, () {}); //value: widget.searchText,
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: buildSearchInput(context)),
      body: Center(
        child: _buildListView(),
      ),
    );
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
          bgColor: Colors.orange),
      refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadHeight: 50.0,
          loadText: Translations.of(context).text("pushToLoad"),
          loadReadyText: Translations.of(context).text("releaseToLoad"),
          loadingText: Translations.of(context).text("loading"),
          loadedText: Translations.of(context).text("loaded"),
          noMoreText: Translations.of(context).text("noMore"),
          moreInfo: Translations.of(context).text("updateAt"),
          bgColor: Colors.orange),
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
        itemCount: _jobList.length,
      ),
      onRefresh:
          () async {
            await getFuturePageData(1);
          },

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
              await getFuturePageData(_page + 1);
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
//    Map itemData = Map();
//    var itemDataStr =
//        "{\"jobTitle\": \"软件开发工程师\",\"location\": \"江苏省/无锡\",\"educationLevel\": \"本科\",\"experienceYears\": \"应届毕业生\",\"salaryFrom\": 4100,\"salaryTo\": 6000,\"publishedOn\": \"2019-02-17T10:46:57\",\"companyId\": \"00000000-0000-0000-0000-0cd827667000\",\"companyName\": \"上海盟威软件有限公司长沙分公司\",\"companyType\": \"上市企业\",\"companySize\": \"50人以下\",\"statement\": \"\",\"logoId\": \"00000000-0000-0000-0000-0cd827667000\",\"id\": \"cd827667-0000-0000-0000-000194666305\"}";
//    try {
//      Map<String, dynamic> mapData = jsonDecode(itemDataStr);
//      itemData = mapData;
//    } catch (e) {
//      print('错误catch s $e');
//    }
    Map itemData = _jobList[i];
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
//        // 这是时间文本
//         Padding(
//          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
//          child:  Text(
//            'publishedOn',
//            style: subtitleStyle,
//          ),
//        ),
//        // 这是评论数，评论数由一个评论图标和具体的评论数构成，所以是一个Row组件
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

        // 左边是标题，时间，评论数等信息
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
                    Text(
                      itemData['companyName'],
                      style: companyStyle,
                    )
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
