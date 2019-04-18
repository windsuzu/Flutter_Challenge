import 'package:flutter/material.dart';
import 'GradientButton.dart';
import 'GradientCircularProgressIndicator.dart';
import 'PaintRoute.dart';
import 'TurnBox.dart';

class CustomizationRoute extends StatefulWidget {
  @override
  _CustomizationRouteState createState() => _CustomizationRouteState();
}

class _CustomizationRouteState extends State<CustomizationRoute>
    with SingleTickerProviderStateMixin {
  double _turns = .0;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      GradientButton(
        colors: [Colors.orange, Colors.red],
        height: 50,
        child: Text('Button1'),
        onTap: () => print('button clicked'),
      ),
      GradientButton(
        colors: [Colors.green, Colors.blue],
        height: 50,
        child: Text('Button2'),
        onTap: () => print('button clicked'),
      ),
      GradientButton(
        colors: [Colors.lightBlue[300], Colors.blueAccent],
        height: 50,
        child: Text('Button3'),
        onTap: () => print('button clicked'),
      ),
      SizedBox(
        height: 12,
      ),
      TurnBox(
        turns: _turns,
        child: Icon(
          Icons.refresh,
          size: 100,
        ),
        onTap: () => setState(() => _turns += 0.2),
      ),
      SizedBox(
        height: 12,
      ),
      PaintRoute(),
      SizedBox(
        height: 24,
      ),
      _createGradientCircularProgressIndicator(),
    ]));
  }

  Widget _createGradientCircularProgressIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GradientCircularProgressIndicator(
          colors: [Colors.red, Colors.orange, Colors.red],
          radius: 50.0,
          stokeWidth: 5.0,
          value: _animationController.value,
        );
      },
    );
  }
}
