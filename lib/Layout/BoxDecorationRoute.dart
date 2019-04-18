import 'package:flutter/material.dart';

///  學習利用 BoxDecoration 漸層

class BoxDecorationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purpleAccent, Colors.blue]),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(color: Colors.black54, offset: Offset(2, 2), blurRadius: 4)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 75),
        child: Text(
          'Button',
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

