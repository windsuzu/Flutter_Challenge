import 'package:flutter/material.dart';

/// 自製含 animation 的 rotatedbox

class TurnBox extends StatefulWidget {
  @override
  _TurnBoxState createState() => _TurnBoxState();

  TurnBox({Key key, this.turns = .0, this.speed = 200, this.onTap, this.child})
      : super(key: key);

  final double turns;
  final int speed;
  final Widget child;
  final GestureTapCallback onTap;
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);

    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: RotationTransition(
          turns: _controller,
          child: widget.child,
        ));
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed),
          curve: Curves.easeOut);
    }
  }
}
