import 'package:flutter/material.dart';


class PageNotFound extends StatelessWidget {

    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("page not found"),
          ),
          body: Container(
              child: new Text("page not found")
          )
      );
    }
}
