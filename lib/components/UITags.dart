import 'package:flutter/material.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/SelectableTags.dart';

typedef VoidCallback OnSelect(Tag tag, List<String> selected);
///不用了
class UITags extends StatefulWidget {
  UITags({Key key,
    @required this.values,
    @required this.onSelect,
    @required this.selected,
    this.column = 4,
    this.symmetry = true,
    this.title,
    this.isSingle = true})
      : super(key: key);
  final List<Tag> values;
  final List<String> selected;
  final OnSelect onSelect;
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

  onTagClick(Tag tag){
    String selectKey = tag.id;
    setState(() {
      if (widget.isSingle) {
        if (widget.selected.contains(selectKey)) {
          widget.selected.clear();
        } else {
          widget.selected.clear();
          widget.selected.add(selectKey);
        }
      } else {
        if (widget.selected.contains(selectKey)) {
          widget.selected.remove(selectKey);
        } else {
          widget.selected.add(selectKey);
        }
      }
    });
    widget.onSelect(tag, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected != null) {
      widget.values.forEach((item) {
        item.active = widget.selected.where((tg) => tg == item.id).length > 0;
      });
    }
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
            fontSize: AppSize.TEXT_SMALL,
            symmetry: widget.symmetry,
            singleItem: widget.isSingle,
            offset: 50,// 默认28
            // margin: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
            activeColor: Theme.of(context).primaryColor,
            color: Colors.white,
            borderRadius: 5,
            borderSide: BorderSide(color: (Colors.grey)),
            activeBorderSide: BorderSide(color: Theme.of(context).primaryColor),
            onPressed: (tag)=>onTagClick(tag),
          ),
        ],
      ),
    );
  }
}
