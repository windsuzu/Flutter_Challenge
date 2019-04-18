import 'package:flutter/material.dart';

/// 學習 ConstraintBox & Stack + Positioned


class StackRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(300, 300)),
      child: Container(
        color: Colors.red,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(height: 250,width: 250, color: Colors.orange,),
            ),
            Positioned(
              bottom: 0,
              child: Container(height: 200,width: 200, color: Colors.yellow,),
            ),
            Positioned(
              bottom: 0,
              child: Container(height: 150,width: 150, color: Colors.green,),
            ),
            Positioned(
              bottom: 0,
              child: Container(height: 100,width: 100, color: Colors.blue,),
            ),
            Positioned(
              bottom: 0,
              child: Container(height: 50,width: 50, color: Colors.purple,),
            ),
          ],
        ),
      ),
    );
  }
}
