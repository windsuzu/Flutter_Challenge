import 'package:flutter/material.dart';

/// 學習使用 SingleChildScrollView

class SingleChildScrollViewRoute extends StatefulWidget {
  @override
  _SingleChildScrollViewRouteState createState() => _SingleChildScrollViewRouteState();
}

class _SingleChildScrollViewRouteState extends State<SingleChildScrollViewRoute> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: str
                  .split("")
                  .map((character) => Text(
                character,
                textScaleFactor: 3,
              ))
                  .toList(),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
