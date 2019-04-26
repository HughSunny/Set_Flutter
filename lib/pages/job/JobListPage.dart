import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/DropdownMenu/drapdown_common.dart';
import 'package:set_flutter/components/DropdownMenu/dropdown_header.dart';
import 'package:set_flutter/components/DropdownMenu/dropdown_list_menu.dart';
import 'package:set_flutter/components/DropdownMenu/dropdown_menu.dart';
import 'package:set_flutter/components/SearchInput.dart';
import 'package:set_flutter/model/GlobalData.dart';
import 'package:set_flutter/model/job_search_entity.dart';
import 'package:set_flutter/pages/job/view/CompanySearchView.dart';
import 'package:set_flutter/pages/job/view/JobListView.dart';
import 'package:set_flutter/pages/job/view/JobSearchView.dart';
import 'package:set_flutter/services/Request.dart';
import 'package:set_flutter/services/job.dart';
import 'package:set_flutter/utils/TsUtils.dart';

class JobListPage extends StatefulWidget {
  final String searchText;

  JobListPage({this.searchText});

  @override
  State<StatefulWidget> createState() {
    return _JobListPageState();
  }
}

class _JobListPageState extends State<JobListPage>
    with SingleTickerProviderStateMixin {
  List<dynamic> _locationData = [];
  List<dynamic> _jobList = [];
  bool _loadMore = true;
  int _page = 1;
  int _pageSize = 10;
  String _keywords = '';

  List<String> companyFilterValue = [];
  List<String> currentCompanyFilterValue = [];
  Map<String, List<String>> jobSelected = {
    'salaryRange': [],
    'publishRange': [],
    'workExperience': [],
    'educationLevel': [],
    'employmentType': []
  };
  Map<String, List<String>> currentJobSelected = {};
  String locationId;

  int locationMainIndex = 0;
  int locationSubIndex = 0;
  @override
  void initState() {
    super.initState();
    List<dynamic> locationDict = GlobalData.lovCacheData['LOCATION'];
    if (locationDict != null) {
      _locationData = locationDict;
    }
    currentCompanyFilterValue.clear();
    currentCompanyFilterValue.addAll(companyFilterValue);
    currentJobSelected = Map.from(jobSelected);
    getPageData(_page, pageSize: 10);
  }

  getPageData(int page, {int pageSize = 0, String keywords}) {
    Map<String, dynamic> queryParam = getQueryFilterParams();

    queryParam['page'] = page;
    queryParam['pageSize'] = pageSize != 0 ? pageSize : _pageSize;
    queryParam['keywords'] = keywords != null ? keywords : _keywords;
    this.setState(() {
      _pageSize = queryParam['pageSize'];
      _keywords = queryParam['keywords'];
    });

    print("getPageData ${queryParam}");
    AppRequest.request(JobService.SEARCH_JOB_LIST, queryParam).then((data) {
      print('getPageData callBack' + data.toString());
      if (data == null) {
        return;
      }
      refreshListView(data, page);
    });
  }

  Future getFuturePageData(int page,
      {int pageSize = 0, String keywords}) async {
//    return new Future(()=>{
//        this.getPageData(page, pageSize:pageSize, keywords:keywords)
//    });
    var queryParam = getQueryFilterParams();
    queryParam['page'] = page;
    queryParam['pageSize'] = pageSize != 0 ? pageSize : _pageSize;
    queryParam['keywords'] = keywords != null ? keywords : _keywords;
    this.setState(() {
      _pageSize = queryParam['pageSize'];
      _keywords = queryParam['keywords'];
    });
    print("getPageData ${queryParam}");
    return AppRequest.request(JobService.SEARCH_JOB_LIST, queryParam)
        .then((data) {
      print('_myClickRequest callBack' + data.toString());
      if (data == null) {
        return;
      }
      refreshListView(data, page);
    });
  }

  refreshListView(Map<String, dynamic> data, int page) {
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
  }

  Map<String, dynamic> getQueryFilterParams() {
    Map<String, dynamic> queryParam = {
      'industryIds': currentCompanyFilterValue,
    };
    if (locationId != null) {
      queryParam['locationId'] = locationId;
    }

    if (getJobFilterValue('salaryRange') != null) {
      queryParam['salaryRangeId'] = getJobFilterValue('salaryRange');
    }
    if (getJobFilterValue('workExperience') != null) {
      queryParam['experienceYearsId'] = getJobFilterValue('workExperience');
    }

    if (getJobFilterValue('educationLevel') != null) {
      queryParam['educationLevelId'] = getJobFilterValue('educationLevel');
    }

    if (getJobFilterValue('employmentType') != null) {
      queryParam['employmentTypeId'] = getJobFilterValue('employmentType');
    }

    if (getJobFilterValue('publishRange') != null) {
      int dayCount = int.parse(getJobFilterValue('publishRange'));
      queryParam['endPublishedOn'] = DateTime.now().toString();
      queryParam['startPublishedOn'] =
          DateTime.now().add(Duration(days: -dayCount)).toString();
    }

    return queryParam;
  }

  String getJobFilterValue(String key) {
    if (currentJobSelected[key] != null && currentJobSelected[key].length > 0) {
      return currentJobSelected[key][0];
    }
    return null;
  }

  void onSearchItemTap(JobSearchEntity job, BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(new PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
      print('Navigator.of(context).pushReplacement');
      return JobListPage(searchText: job.jobTitle);
    }));
//    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//      return JobListPage(searchText:job.jobTitle);
//    }));
  }

  filterCompany(List<String> searchValue) {
    List<String> types = [];
    types.addAll(searchValue);
    this.setState(() {
      currentCompanyFilterValue = types;
      companyFilterValue = types;
    });
    getPageData(1);
//    print('JobListPage filterCompany searchValue ' + searchValue.toString());
  }

  filterJob(Map<String, List<String>> searchValue) {
    this.setState(() {
      currentJobSelected = searchValue;
      jobSelected = searchValue;
    });
    print('JobListPage filterJob searchValue ' + searchValue.toString());
    getPageData(1);
  }

  dropdownControllerSelect(
      {int menuIndex, int index, int subIndex, dynamic data}) {
    print(
        "JobListPage dropdownControllerSelect menuIndex:$menuIndex index:$index subIndex:$subIndex data:$data");
    if (menuIndex == 0) {
      setState(() {
        locationId = data['id'];
      });
      getPageData(1);
    }
  }

  dropdownControllerEvent(DropdownEvent event) {
//    print('JobListPage dropdownControllerEvent event' + event.toString());
//    print('JobListPage dropdownControllerEvent jobSelected' +
//        jobSelected.toString());
//    print('JobListPage dropdownControllerEvent currentJobSelected' +
//        currentJobSelected.toString());
    if (event == DropdownEvent.ACTIVE) {
      List<String> companyTypes = [];
      companyTypes.addAll(currentCompanyFilterValue);

      Map<String, List<String>> jobValues = {};
      currentJobSelected.forEach((key, List<String> value) {
        jobValues[key] = List.from(value);
      });

      setState(() {
        companyFilterValue = companyTypes;
        jobSelected = jobValues;
      });
    }
  }

  Widget buildSearchInput(BuildContext context) {
    return SearchInput((value) async {
      if (value != '') {
//        List<JobBean> list = await widgetControl.search(value);
        List<JobSearchEntity> list = List();
        list.add(JobSearchEntity(value.toString() + '-f', '', '', 'google'));
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
    }, (value) {}, () {}, value: widget.searchText);
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return DropdownHeader(
      height: 50,
      onTap: onTap,
      titles: ['区域', '职位', '公司'],
      getItemLabel: ((data) {
        return null;
//        if (data == null) {
//          return null;
//        }
//        if (data is String) return data;
//        return data["name"];
      }),
    );
  }

  buildTreeMenu() {
    return DropdownTreeMenu(
      selectedIndex: 0,
      subSelectedIndex: -1,
      itemExtent: 45.0,
      background: Color(AppColor.background),
      itemBuilder: (BuildContext context, dynamic data, bool selected) {
        if (!selected) {
          return DecoratedBox(
              decoration: BoxDecoration(
                  border: Border(right: Divider.createBorderSide(context))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        data['name'],
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return DecoratedBox(
              decoration: BoxDecoration(
                  border: Border(
                      top: Divider.createBorderSide(context),
                      bottom: Divider.createBorderSide(context))),
              child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: <Widget>[
                      Container(
                          color: Theme.of(context).primaryColor,
                          width: 3.0,
                          height: 20.0),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              data['name'],
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            )),
                      ),
                    ],
                  )));
        }
      },
      subItemBuilder: (BuildContext context, dynamic data, bool selected) {
        Color color = selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.body1.color;

        return SizedBox(
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    data['name'],
                    style: TextStyle(color: color),
                  ),
                ),

//                         Expanded(
//                            child:  Align(
//                                alignment: Alignment.centerRight,
//                                child:  Text(data['count'].toString())))
              ],
            ),
          ),
        );
      },
      getSubData: (dynamic data) {
        return data['children'];
      },
      data: _locationData,
    );
  }

  DropdownMenu buildDropdownMenu() {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    double height = ScreenUtil.screenHeightDp -
        ScreenUtil.statusBarHeight; //ScreenUtil.bottomBarHeight
//    print('buildDropdownMenu height = $height');
    print('buildDropdownMenu jobSelected = $jobSelected');
    double locationMenuHeight = _locationData.length * kDropdownMenuItemHeight;
    if (locationMenuHeight < 500) {
      locationMenuHeight = 500;
    }
    return DropdownMenu(maxMenuHeight: height, menus: [
      DropdownMenuBuilder(
        builder: (BuildContext context) {
          return buildTreeMenu();
        },
        height: locationMenuHeight,
      ),
      DropdownMenuBuilder(
        builder: (BuildContext context) {
          return JobSearchView(
            jobSelect: filterJob,
            jobFilterValue: jobSelected,
          );
        },
        height: height,
      ),
      DropdownMenuBuilder(
        builder: (BuildContext context) {
          return CompanySearchView(
              companySelect: filterCompany,
              companyFilterValue: companyFilterValue);
        },
        height: height,
      ),
//       DropdownMenuBuilder(
//          builder: (BuildContext context) {
//            return  DropdownListMenu(
//              selectedIndex: ORDER_INDEX,
//              data: ORDERS,
//              itemBuilder: buildDropdownCheckItem,
//            );
//          },
//          height: ORDERS.length * kDropdownMenuItemHeight),
    ]);
  }

  @override
  void didUpdateWidget(JobListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: buildSearchInput(context)),
        body: DefaultDropdownMenuController(
          onSelected: dropdownControllerSelect,
          event: dropdownControllerEvent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
//              Text("职位列表"),
//              Divider(height: 2.0),
              buildDropdownHeader(),
              Expanded(
                  child: Stack(
                children: <Widget>[
                  JobListView(
                    _jobList,
                    _loadMore,
                    getFuturePageData,
                    _page,
                    needTopRefresh: false,
                  ),
                  buildDropdownMenu(),
                ],
              ))
            ],
          ),
        ));
  }

  VoidCallback pressedBtn(BuildContext context) {
    return () {
      TsUtils.showShort('111');
    };
  }
}
