import 'package:flutter/material.dart';
import 'ThemeRoute.dart';

/// 學習使用 WillPopScope 產生 double return 關掉 App 的功能
class FunctionalRoute extends StatelessWidget {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ThemeRoute(),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Click return again to close!'),
            duration: Duration(milliseconds: 500),
          ));
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
    );
  }
}