import 'package:flutter/material.dart';

/// 學習 Container 的 properties

class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 200, height: 150),
      transform: Matrix4.rotationZ(0.2),
      decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.2,
              colors: [Colors.red, Colors.orangeAccent]),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, offset: Offset(2, 2), blurRadius: 4.0)
          ]),
      alignment: Alignment.center,
      child: Text(
        '520',
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}

