import 'package:flutter/material.dart';
import 'EventBusRoute.dart' show EventBus;

/// 學習使用 Notification

class NotificationRoute extends StatefulWidget {
  @override
  _NotificationRouteState createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  var _msg = "";
  var bus = EventBus();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg = notification.msg +
                " - " +
                DateTime.now().toString() +
                "\n" +
                _msg;
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context) => RaisedButton(
                      onPressed: () {
                        MyNotification('Hi').dispatch(context);
                        bus.emit("times", 'test');
                      },
                      child: Text(
                        'Send Notification',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              Text(
                _msg,
                maxLines: 10,
                overflow: TextOverflow.fade,
              )
            ],
          ),
        ));
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
