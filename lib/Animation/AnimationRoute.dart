import 'package:flutter/material.dart';
import 'AnimatedImage.dart';
import 'HeroAnimatedRoute.dart';

class AnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaleAnimationRoute();
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = Tween(begin: 0.0, end: 200.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, animation, secondary) {
                return FadeTransition(
                  opacity: animation,
                  child: HeroAnimatedRoute(),
                );
              })),
      child: AnimatedImage(
        animation: animation,
      ),
    );
  }
}


