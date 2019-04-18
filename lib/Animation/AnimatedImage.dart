import 'package:flutter/material.dart';

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedBuilder(
      animation: animation,
      child: InkWell(
        child: Hero(tag: 'bird', child: Image.asset("images/bluejay.jpg")),
      ),
      builder: (context, child) =>
          Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              child: child,
            ),
          ),
    );
  }
}