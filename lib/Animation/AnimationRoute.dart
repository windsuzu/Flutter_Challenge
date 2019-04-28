import 'package:flutter/material.dart';
import 'HeroAnimatedRoute.dart';
import 'StaggerAnimationRoute.dart';
import 'GuillotineAnimation.dart';
import 'UXAnimationRoute.dart';
import 'LoginAnimationRoute.dart';

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
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
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
          return _createStaggerListTile();
        case 2:
          return _createGuillotineListTile();
        case 3:
          return _createUXAnimationListTile();
        case 4:
          return _createLoginAnimationListTile();
      }
    });
  }

  Widget _createStaggerListTile() {
    return ListTile(
      title: Text("Staggered Animation"),
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondary) => FadeTransition(
                  opacity: animation,
                  child: StaggerAnimationRoute(),
                ),
          )),
    );
  }

  Widget _createGuillotineListTile() {
    return ListTile(
      title: Text("Guillotine Menu"),
      onTap: () => Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, animation, secondary) {
            var slideAnimation =
                Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
                    CurvedAnimation(parent: animation, curve: Curves.linear));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: slideAnimation,
                child: GuillotineAnimation(),
              ),
            );
          })),
    );
  }

  Widget _createUXAnimationListTile() {
    return ListTile(
      title: Text("UX Animations"),
      onTap: () => Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, animation, secondary) {
            var slideAnimation =
                Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                    CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(
              position: slideAnimation,
              child: UXAnimationRoute(),
            );
          })),
    );
  }

  Widget _createLoginAnimationListTile() {
    return ListTile(
      title: Text("Login Animation"),
      onTap: () => Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, animation, secondary) {
            return FadeTransition(
              opacity: animation,
              child: LoginAnimationRoute(),
            );
          })),
    );
  }
}
