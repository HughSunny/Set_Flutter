import 'package:flutter/material.dart';
import 'package:set_flutter/app/StyleConstants.dart';
import 'package:set_flutter/components/SelectableTags.dart';

typedef OnSelect(dynamic selectItem, List<String> selected);

class UISelectTags extends StatefulWidget {
  UISelectTags(
      {Key key,
      @required this.values,
      @required this.onSelect,
      @required this.selected,


      this.column = 4,
      this.symmetry = true,
      this.title,
      this.isSingle = true,
      this.emptySelect = false,
        this.emptySelectTitle = '不限',
        this.emptySelectValue = '',
      })
      : super(key: key);
  final List<dynamic> values;
  final List<String> selected;
  final OnSelect onSelect;
  final bool isSingle;
  final bool symmetry;
  final String title;
  final int column;
  final bool emptySelect;
  final String emptySelectTitle;
  final String emptySelectValue;

  @override
  _UISelectTagsState createState() => new _UISelectTagsState();
}

class _UISelectTagsState extends State<UISelectTags> {
  List<Tag> tags = [];
//  List<String> currentSelected = [];

  @override
  void didUpdateWidget(UISelectTags oldWidget) {
    super.didUpdateWidget(oldWidget);
//    print("-----UISelectTagsState didUpdateWidget selected = " +
//        widget.selected.toString());
  }

  @override
  void didChangeDependencies() {
    setState(() {
//      print("didChangeDependencies tags = " + tags.toString());
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

//    print("-----UISelectTagsState initState ");

    if (widget.values != null) {
      tags.clear();

      if (widget.emptySelect) {
        tags.add(Tag(
          title: widget.emptySelectTitle,
          id: widget.emptySelectValue,));
      }

      widget.values.forEach((item) {
        if (item is String) {
          tags.add(Tag(
              title: item,
              id: item,));
          //active: widget.selected.where((tg) => tg == item).length > 0
        } else {
          tags.add(Tag(
              title: item['name'],
              id: item['id'],
              ));
          //active:  widget.selected.where((tg) => tg == item['id']).length > 0
        }
      });
    }
  }

  onTagClick(Tag tag) {
    String selectKey = tag.id;
    var selectItem = null;

    for (int i = 0; i < widget.values.length; i++) {
      dynamic item = widget.values[i];
      if (item is String) {
        if (item == tag.id) {
          selectItem = item;
          break;
        }
      } else {
        if (item['id'] == tag.id) {
          selectItem = item;
          break;
        }
      }
    }

    setState(() {
      if (widget.isSingle) {
        if (widget.selected.contains(selectKey)) {
          widget.selected.clear();
        } else {
          widget.selected.clear();
//          widget.selected.add(selectKey);
          if (!(widget.emptySelect && widget.emptySelectValue == '')) {
            widget.selected.add(selectKey);
          }
        }
      } else {
        if (widget.emptySelect && tags.indexOf(tag) == 0) {
          //点击了'不限'的按钮
          if (widget.selected.contains(selectKey)) {
            widget.selected.remove(selectKey);
          } else {
            widget.selected.clear();
//            widget.selected.add(selectKey);
            if (widget.emptySelectValue != '') {
              widget.selected.add(selectKey);
            }
          }
        } else {
          if (widget.selected.contains(selectKey)) {
            widget.selected.remove(selectKey);
          } else {
            widget.selected.add(selectKey);
          }
        }

      }
    });
    if (widget.onSelect != null) {
      widget.onSelect(selectItem, widget.selected);
    }

    print("----UISelectTagsState onTagClick currentSelected = " +
        widget.selected.toString());
//    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected != null) {
      tags.forEach((item) {
        item.active = widget.selected.where((tg) => tg == item.id).length > 0;
      });

      if (widget.emptySelect ) {
        tags[0].active = widget.selected.length == 0;
      }
    }

    Widget titleView = Offstage(
        offstage: widget.title == null,
        child: Text(widget.title != null ? widget.title : '',
            style: new TextStyle(fontSize: AppSize.TEXT_NORMAL)));
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleView,
          SelectableTags(
            tags: tags,
            columns: widget.column,
            fontSize: AppSize.TEXT_SMALL,
            symmetry: widget.symmetry,
            singleItem: widget.isSingle,
            offset: 50,
            // 默认28
            // margin: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
            activeColor: Theme.of(context).primaryColor,
            color: Colors.white,
            borderRadius: 5,
            borderSide: BorderSide(color: (Colors.grey)),
            activeBorderSide: BorderSide(color: Theme.of(context).primaryColor),
            onPressed: (tag) => onTagClick(tag),
          ),
        ],
      ),
    );
  }
}
