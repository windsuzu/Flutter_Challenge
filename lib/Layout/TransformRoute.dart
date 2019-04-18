import 'package:flutter/material.dart';

/// 學習 transform

class TransformRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0.3),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.deepOrange,
            child: Text(
              'Hello World!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
