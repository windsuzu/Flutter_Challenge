import 'package:flutter/material.dart';

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation, this.image})
      : super(key: key, listenable: animation);

  final Image image;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedBuilder(
      animation: animation,
      child: Hero(tag: 'bluejay', child: image),
      builder: (context, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
