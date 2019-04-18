import 'package:flutter/material.dart';

/// 學習使用 Gesture Detector

class GestureDetectorRoute extends StatefulWidget {
  @override
  _GestureDetectorRouteState createState() => _GestureDetectorRouteState();
}

class _GestureDetectorRouteState extends State<GestureDetectorRoute> {
  String _operation = "No Gesture detected!";
  double _top, _left, _width;

  @override
  void initState() {
    _left = 0.0;
    _top = 0.0;
    _width = 120;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: Container(
              decoration: ShapeDecoration(
                  color: Theme.of(context).primaryColor,
                  shadows: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 5),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              alignment: Alignment.center,
              width: _width,
              height: 80.0,
              child: Text(
                _operation,
                style: TextStyle(color: Colors.white),
              ),
            ),

// 只允許 縱向拖移
//            onVerticalDragUpdate: (e) {
//              setState(() => _top += e.delta.dy);
//            },

            onPanDown: (e) => updateText('start pos:\n${e.globalPosition}'),
            // 實現拖曳功能
            onPanUpdate: (e) {
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (e) => updateText('velocity:\n${e.velocity}'),
            onTap: () => updateText('Tap'),
            onDoubleTap: () => updateText('Double Tap'),
            onLongPress: () => updateText('Long Press'),
          ),
        ),
        Positioned(
          bottom: 4,
          child: GestureDetector(
            // 實現雙指手勢放大縮小
            onScaleUpdate: (e) {
              setState(() {
                _width = 200 * e.scale.clamp(.8, 10.0);
              });
            },
            child: Container(
              width: _width,
              child: RaisedButton(
                color: Colors.green,
                shape:
                    StadiumBorder(side: BorderSide(color: Colors.greenAccent)),
                onPressed: () {
                  setState(() {
                    _left = 0;
                    _top = 0;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.zoom_out_map,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Initialize',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void updateText(String text) => setState(() => _operation = text);
}
