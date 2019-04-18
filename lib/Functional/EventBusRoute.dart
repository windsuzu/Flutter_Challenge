import 'package:flutter/material.dart';

typedef void EventCallback(arg);

class EventBus {
  EventBus._internal();

  static EventBus _singleton = new EventBus._internal();

  factory EventBus() => _singleton;

  var _emap = new Map<Object, List<EventCallback>>();

  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;

    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

/// 學習使用 EventBus 接聽 (bus.on)

class EventBusRoute extends StatefulWidget {
  @override
  _EventBusRouteState createState() => _EventBusRouteState();
}

class _EventBusRouteState extends State<EventBusRoute> {
  var bus = EventBus();
  var _count = 0;

  @override
  void initState() {
    bus.on("times", (arg) {
      print(arg);
      setState(() => _count++);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('notification times: $_count'));
  }
}
