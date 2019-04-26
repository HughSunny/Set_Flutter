import 'dart:async';

import 'package:flutter/material.dart';
import 'package:set_flutter/pages/job/view/JobListView.dart';
import 'package:set_flutter/services/Request.dart';
import 'package:set_flutter/services/job.dart';

class ProgressNetworkPage extends StatefulWidget {
  @override
  _ProgressNetworkPageState createState() => new _ProgressNetworkPageState();
}

class _ProgressNetworkPageState extends State<ProgressNetworkPage> {
  Future future;
  List<dynamic> _jobList = [];
  bool _loadMore = true;
  int _page = 1;
  int _pageSize = 10;
  String _keywords = '';
  @override
  void initState() {
    super.initState();
    future = getFuturePageData(1);
  }

  Future<Map<String, dynamic>> getFuturePageData(int page,
      {int pageSize = 0, String keywords}) async {
    Map<String, dynamic> queryParam = {};
    queryParam['page'] = page;
    queryParam['pageSize'] = pageSize != 0 ? pageSize : _pageSize;
    queryParam['keywords'] = keywords != null ? keywords : _keywords;
    this.setState(() {
      _pageSize = queryParam['pageSize'];
      _keywords = queryParam['keywords'];
    });
    print("getPageData ${queryParam}");
    Map<String, dynamic> data = await AppRequest.request(JobService.SEARCH_JOB_LIST, queryParam);
    print('request callBack' + data.toString());
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
    return data;
  }

  _buildListView() {
    return JobListView(
      _jobList,
      _loadMore,
      getFuturePageData,
      _page,
      needTopRefresh: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProgressNetworkPage'),
      ),
      body:  new FutureBuilder(
        builder: (context, AsyncSnapshot async) {
          if (async.connectionState == ConnectionState.active ||
              async.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
          if (async.connectionState == ConnectionState.done) {
            if (async.hasError) {
              print(async.toString());
              return new Center(
                child: new Text('服务器错误，请稍后重试'),
              );
            } else if (async.hasData) {
              return _buildListView();
            }
          }
        },
        future: future,
      ),

    );
  }
}
