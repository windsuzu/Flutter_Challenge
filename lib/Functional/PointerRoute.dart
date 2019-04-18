import 'package:flutter/material.dart';

/// 學習 pointer 原理

class PointerRoute extends StatefulWidget {
  @override
  _PointerRouteState createState() => _PointerRouteState();
}

class _PointerRouteState extends State<PointerRoute> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          width: 300.0,
          height: 150.0,
          child: Text(_event?.toString() ?? "",
              style: TextStyle(color: Colors.white)),
        ),
      ),
      onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
      onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }
}
