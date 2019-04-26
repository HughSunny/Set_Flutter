import 'package:flutter/material.dart';

class TagTest extends StatefulWidget {
  @override
  _TagTestState createState() => new _TagTestState();
}

class _TagTestState extends State<TagTest> {
  bool _active = false;

  void _handleTagChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
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
        child: UITag(
          value: 'UITAG',
          active: _active,
          onChanged: _handleTagChanged,
        ),
      ),
    );
  }
}

class UITag extends StatefulWidget {
  UITag(
      {Key key,
      @required this.value,
      @required this.onChanged,
      this.active: false,
      this.height = 50,
      this.width = 100})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;
  final String value;
  final double height;
  final double width;

  @override
  _UITagState createState() => new _UITagState();
}

class _UITagState extends State<UITag> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        decoration: BoxDecoration(
          color: widget.active
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          border: new Border.all(
              color:
                  widget.active ? Theme.of(context).primaryColor : Colors.grey,
              width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Text(widget.value,
            style: TextStyle(color: widget.active?Colors.white:Colors.black),
          ),
        ),
//        child: Padding(
//          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//          child: Text(
//            widget.value,
//            style:
//                TextStyle(color: widget.active ? Colors.white : Colors.black),
//          ),
//        ),
      ),
    );
  }
}
