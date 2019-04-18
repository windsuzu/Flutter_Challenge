import 'package:flutter/material.dart';

/// Use Flex to create a Italy flag

class FlexRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: BeveledRectangleBorder(
              side: BorderSide(width: 1, color: Colors.black87))),
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
              )),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
