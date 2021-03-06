import 'package:flutter/material.dart';

class AutoCloseKeyboard extends StatelessWidget {
  final Widget child;

  const AutoCloseKeyboard({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: child,
    );
  }
}