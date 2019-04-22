import 'package:flutter/material.dart';
import 'HeroAnimatedRoute.dart';
import 'StaggerAnimationRoute.dart';

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
    controller =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _infoListView();
  }

  Widget _infoListView() {
    return ListView.builder(itemBuilder: (context, index) {
      switch (index) {
        case 0:
          return HeroListTile();
        case 1:
          return ListTile(
            title: Text("Staggered Animation"),
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondary) =>
                        FadeTransition(
                          opacity: animation,
                          child: StaggerAnimationRoute(),
                        ),)),
          );
      }
    });
  }
}
