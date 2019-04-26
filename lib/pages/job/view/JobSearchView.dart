import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/DropdownMenu/drapdown_common.dart';
import 'package:set_flutter/components/SelectableTags.dart';
import 'package:set_flutter/components/UISelectTags.dart';
import 'package:set_flutter/components/UITags.dart';
import 'package:set_flutter/model/GlobalData.dart';

typedef JobSelect(Map<String,List<String>> searchValue);

class JobSearchView extends DropdownWidget {
  final JobSelect jobSelect;

  final Map<String, List<String>> jobFilterValue;

  JobSearchView({
    this.jobSelect,
    this.jobFilterValue,
  });

  @override
  _JobSearchViewState createState() => new _JobSearchViewState();
}

class _JobSearchViewState extends DropdownState<JobSearchView> {
  @override
  void initState() {
    super.initState();
    _salaryRange = GlobalData.lovCacheData['SALARYRANGE'];

    _publishRange = GlobalData.lovCacheData['PUBLISH_RANGE'];

    _workExperience = GlobalData.lovCacheData['YEARSEXPERIENCE'];

    _educationLevel = GlobalData.lovCacheData['EDUCATIONLEVEL'];

    _employmentType = GlobalData.lovCacheData['EMPLOYMENTTYPE'];
  }

  List<dynamic> _salaryRange = [];
  List<dynamic> _publishRange = [];
  List<dynamic> _workExperience = [];
  List<dynamic> _educationLevel = [];
  List<dynamic> _employmentType = [];

  _handleTagChanged(dynamic newValue, List<String> selected) {

  }

  @override
  Widget build(BuildContext context) {
    List<String> _selectSalary = widget.jobFilterValue['salaryRange'];
    List<String> _selectPublish = widget.jobFilterValue['publishRange'];
    List<String> _selectWorkExperience = widget.jobFilterValue['workExperience'];
    List<String> _selectEducationLevel = widget.jobFilterValue['educationLevel'];
    List<String> _selectEmploymentType = widget.jobFilterValue['employmentType'];
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: new Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: RaisedButton(
                onPressed: pressedBtn(context),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "确定",
                  style: TextStyle(
                      color: Colors.white, fontSize: AppSize.TEXT_LARGE),
                ),
                disabledColor: Colors.grey,
                highlightColor: Theme.of(context).primaryColorDark,
//                colorBrightness:Brightness,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UISelectTags(
                      title: '月薪范围',
                      values: _salaryRange,
                      isSingle: true,
                      selected: _selectSalary,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, AppSize.MARGIN_COMMON, 0, 0),
                      child: UISelectTags(
                        title: '发布时间',
                        values: _publishRange,
                        isSingle: true,
                        selected: _selectPublish,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, AppSize.MARGIN_COMMON, 0, 0),
                      child: UISelectTags(
                        title: '工作经验',
                        values: _workExperience,
                        isSingle: true,
                        selected: _selectWorkExperience,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, AppSize.MARGIN_COMMON, 0, 0),
                      child: UISelectTags(
                        title: '学历要求',
                        values: _educationLevel,
                        isSingle: false,
                        selected: _selectEducationLevel,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, AppSize.MARGIN_COMMON, 0, 0),
                      child: UISelectTags(
                        title: '工作性质',
                        values: _employmentType,
                        isSingle: true,
                        selected: _selectEmploymentType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback pressedBtn(BuildContext context) {
    return () {
      assert(controller != null);
      controller.select(null, index: 1);
      if (widget.jobSelect != null) {
        widget.jobSelect(widget.jobFilterValue);
      }

    };
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        {}
        break;
      case DropdownEvent.ACTIVE:
        {}
        break;
    }
  }
}
