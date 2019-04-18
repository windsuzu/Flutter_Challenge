import 'package:flutter/material.dart';

///  利用 Wrap 來保證 Row 不會 Overflow

class WrappedRowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: Text('Laurens'),
        ),
      ],
    );
  }
}
