
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/DropdownMenu/drapdown_common.dart';
import 'package:set_flutter/components/UISelectTags.dart';
import 'package:set_flutter/model/GlobalData.dart';

typedef CompanySelect(List<String> searchValue);

class CompanySearchView extends DropdownWidget {
  final CompanySelect companySelect;

  final List<String> companyFilterValue;

  CompanySearchView({this.companySelect, this.companyFilterValue,});
  @override
  _CompanySearchViewState createState()  =>  new _CompanySearchViewState();
}

class _CompanySearchViewState extends DropdownState<CompanySearchView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CompanySearchView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _handleTagChanged(dynamic newValue, List<String> selected) {
//    setState(() {
//
//      _selectCompanyType = selected;
//    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> companyTypeDict = GlobalData.lovCacheData['COMPANYTYPE'];
//    print("CompanySearchView build" + widget.companyFilterValue.toString() );
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
                child: Text("确定", style: TextStyle(color: Colors.white,fontSize: AppSize.TEXT_LARGE),),
                disabledColor: Colors.grey,
                highlightColor: Theme.of(context).primaryColorDark,
                // 按下的背景色
//                splashColor: Colors.green,
                // 水波纹颜色
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
                      title: '行业领域',
                      values: companyTypeDict,
                      isSingle: false,
                      selected: widget.companyFilterValue,
                      onSelect:_handleTagChanged,
                      emptySelect: true,
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
      if (widget.companySelect != null) {
        widget.companySelect(widget.companyFilterValue);
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
