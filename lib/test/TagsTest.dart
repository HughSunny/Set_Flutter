import 'package:flutter/material.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/SelectableTags.dart';
import 'package:set_flutter/test/TagTest.dart';

class TagsTest extends StatefulWidget {
  @override
  _TagsTestState createState() => new _TagsTestState();
}

class _TagsTestState extends State<TagsTest> {
  List<String> _list = [
    'plugin updates','Facebook','哔了狗了QP又不够了',
    'Kirchhoff','Italy','France','Spain','Dart','Foo','Select','lorem ip','9',
    'Star','Flutter Selectable Tags','1','Hubble','2','Input flutter tags',
    '美术',
    '互联网',
    '炫舞时代',
    '篝火营地',
  ];
  List<Tag> _selectableTags = [];
  @override
  void initState() {
    super.initState();
    int cnt = 0;
    _list.forEach((item)
    {
      _selectableTags.add (
          Tag (id: cnt.toString(),
              title: item,
              active: false,
          )
      );
      cnt++;
    }
    );
  }

  void _handleTagChanged(Tag newValue) {
    print(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('TagTest'),
      ),
      body: Container(
        child: UITags(
          title: '测试',
          values: _selectableTags,
          onChanged: _handleTagChanged,
        ),
      ),
    );
  }
}

class UITags extends StatefulWidget {
  UITags({Key key,
    @required this.values,
    @required this.onChanged,
    this.selected,
    this.column = 4,
    this.symmetry = true,
    this.title,
    this.isSingle = true})
      : super(key: key);
  final List<Tag> values;
  final List<String> selected;
  final ValueChanged<Tag> onChanged;
  final bool isSingle;
  final bool symmetry;
  final String title;
  final int column;

  @override
  _UITagsState createState() => new _UITagsState();
}

class _UITagsState extends State<UITags> {

  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget titleView =  Offstage(
      offstage: widget.title == null,
      child:Text(
      widget.title != null?widget.title:'' ,
      style: new TextStyle(fontSize:AppSize.TEXT_NORMAL )));
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          titleView,
          SelectableTags(
            tags: widget.values,
            columns: widget.column,
            fontSize: AppSize.TEXT_NORMAL,
            symmetry: widget.symmetry,
            singleItem: widget.isSingle,
            offset: 50,// 默认28
            // margin: EdgeInsets.all(10),
            // margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
            activeColor: Theme.of(context).primaryColor,
            color: Colors.white,
            borderRadius: 5,
            borderSide: BorderSide(color: (Colors.grey)),
            activeBorderSide: BorderSide(color: Theme.of(context).primaryColor),
            height:50,
            onPressed: (tag){
              widget.onChanged(tag);
//              setState(() {
//                _selectableOnPressed = tag.toString();
//              });
            },
          ),
        ],
      ),
    );
  }
}
