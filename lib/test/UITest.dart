import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('ButtonUtil'),
      ),
      body: Container(),
    );
  }
}


class TestStatefulWidget extends StatefulWidget {
  @override
  _TestStatefulWidgetsState createState()  =>  new _TestStatefulWidgetsState();
}

class _TestStatefulWidgetsState extends State<TestStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

