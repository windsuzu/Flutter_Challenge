import 'package:flutter/material.dart';
import 'StaggerAnimation.dart';

class HeroAnimatedRoute extends StatefulWidget {
  @override
  _HeroAnimatedRouteState createState() => _HeroAnimatedRouteState();
}

class _HeroAnimatedRouteState extends State<HeroAnimatedRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller
          .forward()
          .orCancel;
      //再反向执行动画
      await _controller
          .reverse()
          .orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: Colors.black,
            constraints:
            BoxConstraints.tightFor(width: double.infinity, height: 300),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Hero(
                  tag: 'bird',
                  child: Image.asset(
                    'images/bluejay.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 12,
                  child: Text(
                    'Blue Jay',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned( top: 4, child: Text('StaggerAnimation'),),
              _createAnimatedRect(),
            ],
          )
        ],
      ),
    );
  }

  Widget _createAnimatedRect() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _playAnimation,
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          child: StaggerAnimation(controller: _controller),
        ),
      ),
    );
  }
}