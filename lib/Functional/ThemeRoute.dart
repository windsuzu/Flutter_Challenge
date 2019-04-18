import 'package:flutter/material.dart';
import 'EventBusRoute.dart';
import 'GestureDetectorRoute.dart';
import 'InheritedRoute.dart';
import 'PointerRoute.dart';
import 'NotificationRoute.dart';
import 'package:flutter_challenge/generated/i18n.dart';

class ThemeRoute extends StatefulWidget {
  @override
  _ThemeRouteState createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  Color _themeColor = Colors.teal;
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            primarySwatch: _themeColor,
            primaryColor: _themeColor,
            iconTheme: IconThemeData(color: _themeColor)),
        child: Scaffold(
          body: IndexedStack(
            index: _bottomSelectedIndex,
            children: <Widget>[
              _themeBody(),
              ChildWidget(),
              PointerRoute(),
              GestureDetectorRoute(),
              EventBusRoute(),
              NotificationRoute(),
            ],
          ),
          floatingActionButton: _bottomSelectedIndex != 0
              ? null
              : FloatingActionButton(
                  child: Icon(Icons.palette),
                  onPressed: () => setState(() => _themeColor =
                      _themeColor == Colors.teal ? Colors.amber : Colors.teal)),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: _themeColor,
              currentIndex: _bottomSelectedIndex,
              onTap: (index) => setState(() => _bottomSelectedIndex = index),
              items: <String>[
                S.of(context).Theme,
                S.of(context).Inherited,
                S.of(context).Pointer,
                S.of(context).Gesture,
                S.of(context).EventBus,
                S.of(context).Notify
              ].map((title) {
                Map<String, Icon> icons = {
                  S.of(context).Theme: Icon(Icons.home),
                  S.of(context).Inherited: Icon(Icons.all_inclusive),
                  S.of(context).Pointer: Icon(Icons.control_point_duplicate),
                  S.of(context).Gesture: Icon(Icons.gesture),
                  S.of(context).EventBus: Icon(Icons.event_seat),
                  S.of(context).Notify: Icon(Icons.notifications_active),
                };
                return BottomNavigationBarItem(
                    icon: icons[title], title: Text('$title'));
              }).toList()),
        ));
  }

  /// 學習使用 Theme
  Widget _themeBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(Icons.favorite),
          Icon(Icons.airport_shuttle),
          Text("Colors with Theme")
        ]),
        Theme(
          data: Theme.of(context).copyWith(
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: Colors.black)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("Colors with Inner Theme")
              ]),
        )
      ],
    );
  }
}
