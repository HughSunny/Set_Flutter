import 'dart:async';

import 'package:flutter/material.dart';

class OfficialDemo extends StatefulWidget {
  final String title;

  OfficialDemo({Key key, this.title}) : super(key: key);

//  @override
//  State<StatefulWidget> createState() {
//    _OfficialDemoState state = new _OfficialDemoState();
//    return state;
//  }

  @override
  _OfficialDemoState createState() =>  new _OfficialDemoState();
}


class _OfficialDemoState extends State<OfficialDemo> with WidgetsBindingObserver {

  int _counter = 0;
  AppLifecycleState _lastLifecyleState;
  bool toggleState = true;
  bool showtext = true;
  Timer t2;



  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecyleState = state;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void toggleBlinkState() {
    setState(() {
      toggleState = !toggleState;
    });
    var twenty = const Duration(milliseconds: 1000);
    if (toggleState == false) {
      t2 = Timer.periodic(twenty, (Timer t) {
        toggleShowText();
      });
    } else {
      t2.cancel();
    }
  }

  void toggleShowText() {
    setState(() {
      showtext = !showtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            // 状态获取
            Text(
                'The most recent lifecycle state this widget observed was: ${_lastLifecyleState != null ? _lastLifecyleState : ''}',
                textDirection: TextDirection.ltr),
//            Container(
////              width: MediaQuery.of(context).size.width,
////              width:double.infinity,
//              alignment:Alignment.topLeft,
//              width:300,
//              height: 100,
//              child: CustomCard(
//                index: _index,
//                onPress: () {
//                  print('Card $_index');
//                },
//              ),
//            ),

//            Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//
//              ],
//            )

//            CustomCard(
//              index: _index,
//              onPress: () {
//                print('Card $_index');
//              },
//            ),

            //IMAGE TEST
//            new Image.asset('assets/images/food01.jpeg'),

//            new Image.network(
//              'http://pic.baike.soso.com/p/20130828/20130828161137-1346445960.jpg',
//              scale: 2.0,
//            ),

            // state 状态管理  padding使用
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: RaisedButton(
                    onPressed: toggleBlinkState,
                    child: (toggleState
                        ? (Text('Blink'))
                        : (Text('Stop Blinking')))))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'container_test');
          _incrementCounter();
        },
//        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
