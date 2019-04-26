import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/services/GetUrl.dart';
import 'package:set_flutter/services/Request.dart';
import 'package:set_flutter/services/company.dart';
import 'package:set_flutter/services/job.dart';
import 'package:set_flutter/utils/Helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:set_flutter/utils/TsUtils.dart';

//BannerView 测试
class JobDetailPage extends StatefulWidget {
  final Map<String, dynamic> _jobItem;

  JobDetailPage(this._jobItem);

  @override
  _JobDetailPageState createState() => new _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  void initState() {
    super.initState();




    var jobItem = widget._jobItem;
    getCompanyInfo(jobItem['companyId']);
    getJobInfo(jobItem['id']);
  }

  getCompanyInfo(String companyId) {
    var queryParam = {
      'id': companyId,
    };
    AppRequest.request(CompanyService.GET_COMPANY_INFO_BY_ID, queryParam)
        .then((data) {
      print('_myClickRequest callBack' + data.toString());
      if (data == null) {
        return;
      }
      this.setState(() {
        companyInfo = data;
      });
    });
  }

  getJobInfo(String companyId) {
    var queryParam = {
      'id': companyId,
    };
    AppRequest.request(JobService.GET_JOB_DETAIL, queryParam).then((data) {
      print('_myClickRequest callBack' + data.toString());
      if (data == null) {
        return;
      }
      this.setState(() {
        jobInfo = data;
      });
    });
  }

  Map<String, dynamic> jobInfo = new Map();
  Map<String, dynamic> companyInfo = new Map();

  VoidCallback pressedBtn(BuildContext context) {
    return () {
      TsUtils.showShort('pressedBtn');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "职位详情",
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.MARGIN_COMMON),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//              Text("职位详情"),
                      _buildJobTitle(),
                      _buildCompanyRow(),
                      _buildJobDesc(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Color(0xFFEEEEEE),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(AppSize.MARGIN_LARGE, 0,
                      AppSize.MARGIN_LARGE, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlineButton(
                            child: Text("立即沟通"),
                            onPressed: pressedBtn(context),
                            textColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(10),
                            color: Colors.white30,
                            highlightedBorderColor:Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 1)),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)
//                            clipBehavior: Clip.antiAlias,
                            ),
                      ),
                      Container(width: AppSize.MARGIN_COMMON,),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          onPressed: pressedBtn(context),
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(10),
                          child: Text("投递简历",style: TextStyle(color: Colors.white),),
                          disabledColor: Colors.grey,
                          highlightColor: Theme.of(context).primaryColorDark,
                          // 按下的背景色
                          splashColor: Colors.green,
                        ),
                      ),
                    ],
                  )),
            )
          ]),
    );
  }

  TextStyle jobTitleStyle = new TextStyle(
      color: const Color(AppColor.mainTextColor),
      fontSize: AppSize.TEXT_SMALL);

// 列表中salary的样式
  TextStyle salaryTextStyle = new TextStyle(
      fontSize: AppSize.TEXT_SMALL, color: Color(AppColor.primary_0));

  Widget _buildJobDesc() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "岗位职责",
          style: AppText.title,
        ),
        Html(
          data: (jobInfo['jobDescription'] != null
              ? jobInfo['jobDescription']
              : ''),
          blockSpacing: 2,
          padding: EdgeInsets.all(AppSize.MARGIN_SMALL),
          onLinkTap: (url) {
            print("Opening $url...");
          },
//      customRender: (node, children) {
//        if (node is dom.Element) {
//          switch (node.localName) {
//            case "custom_tag":
//              return Column(children: children);
//          }
//        }
//      },
        ),
      ],
    );
  }

  Widget _buildCompanyRow() {
    var desc = [];
    if (companyInfo['companyType'] != null) {
      desc.add(companyInfo['companyType']);
    }
    if (companyInfo['industry'] != null) {
      desc.add(companyInfo['industry']);
    }
    if (companyInfo['companySize'] != null) {
      desc.add(companyInfo['companySize']);
    }

    var companyLogo = companyInfo['logoId'] != null ? Padding(
      padding: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
      child: Image.network(
          GetUrl.getShowImageUrl(companyInfo['logoId'], targetSize: 80),
          width: AppSize.ICON_LARGE,
          height: AppSize.ICON_LARGE),
    ): null;

    var jobInfo = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(companyInfo['name'],
            style: TextStyle(fontSize: AppSize.TEXT_LARGE)),
        Text(
          desc.join('|'),
          style: jobTitleStyle,
        ),
      ],
    );

    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, AppSize.MARGIN_COMMON),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: jobInfo,
            ),
            companyLogo,
          ],
        ));
  }

  Widget _buildJobTitle() {
    String salary =
        Helper.formatSalary(jobInfo['salaryFrom'], jobInfo['salaryTo']);
    var desc = [];

    if (jobInfo['location'] != null) {
      desc.addAll(jobInfo['location'].split('/'));
    }
    if (jobInfo['experienceYears'] != null) {
      desc.add(jobInfo['experienceYears']);
    }
    if (jobInfo['educationLevel'] != null) {
      desc.add(jobInfo['educationLevel']);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, AppSize.MARGIN_COMMON),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(jobInfo['jobTitle'],
              style: TextStyle(fontSize: AppSize.TEXT_LARGE)),
          Row(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.fromLTRB(0, 0, AppSize.MARGIN_COMMON, 0),
                child: Text(salary, style: salaryTextStyle),
              ),
              Expanded(
                  child: new Text(
                desc.join('|'),
                style: jobTitleStyle,
              )),
            ],
          )
        ],
      ),
    );
  }
}
