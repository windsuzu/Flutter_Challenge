import 'package:flutter/material.dart';
import 'dart:math';

/// refer: https://www.didierboelens.com/2018/06/animations-in-flutter---easy-guide---tutorial/

class GuillotineAnimation extends StatefulWidget {
  @override
  _GuillotineAnimationState createState() => _GuillotineAnimationState();
}

class _GuillotineAnimationState extends State<GuillotineAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 利用 Satck 模擬 AppBar + 前頁面
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Page(),
            GuillotineMenu(),
          ],
        ),
      ),
    );
  }
}

/// 前頁面
class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff222222),
      child: Column(
        children: <Widget>[
          SizedBox(height: 90.0),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}


/// AppBar + menu + animation
class GuillotineMenu extends StatefulWidget {
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}

enum _GuillotineAnimationStatus { closed, open, animating }

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  double rotationAngle = 0.0;
  AnimationController _controller;
  Animation<double> _rotationAnimation;
  Animation<double> _fadeAnimation;
  _GuillotineAnimationStatus menuAnimationStatus =
      _GuillotineAnimationStatus.closed;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() => setState(() {}))
          ..addStatusListener((status) => _updateAnimationStatus(status));
    _rotationAnimation = Tween(begin: -pi / 2, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceIn));
    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.ease)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleMenuOpenClose() {
    if (menuAnimationStatus == _GuillotineAnimationStatus.closed) {
      _controller.forward().orCancel;
    } else if (menuAnimationStatus == _GuillotineAnimationStatus.open) {
      _controller.reverse().orCancel;
    }
  }

  void _updateAnimationStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        menuAnimationStatus = _GuillotineAnimationStatus.open;
        break;
      case AnimationStatus.dismissed:
        menuAnimationStatus = _GuillotineAnimationStatus.closed;
        break;
      default:
        menuAnimationStatus = _GuillotineAnimationStatus.animating;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Transform.rotate(
      angle: _rotationAnimation.value,
      origin: Offset(24, 56),
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Color(0xff333333),
          child: Stack(
            children: <Widget>[
              _buildMenuTitle(screenWidth),
              _buildMenuIcon(),
              _buildMenuContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTitle(double width) {
    return Positioned(
      top: 32,
      left: 40,
      width: width,
      height: 24,
      child: Transform.rotate(
        alignment: Alignment.topLeft,
        origin: Offset.zero,
        angle: pi / 2.0,
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Text(
                "ACTIVITY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuIcon() {
    return Positioned(
      top: 32.0,
      left: 4.0,
      child: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () => _handleMenuOpenClose(),
      ),
    );
  }

  Widget _buildMenuContent() {
    final List<Map> _menus = <Map>[
      {
        "icon": Icons.person,
        "title": "profile",
        "color": Colors.white,
      },
      {
        "icon": Icons.view_agenda,
        "title": "feed",
        "color": Colors.white,
      },
      {
        "icon": Icons.swap_calls,
        "title": "activity",
        "color": Colors.cyan,
      },
      {
        "icon": Icons.settings,
        "title": "settings",
        "color": Colors.white,
      },
    ];
    return Padding(
      padding: EdgeInsets.only(left: 64, top: 96),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _menus.map((item) {
            return ListTile(
              leading: Icon(
                item["icon"],
                color: item["color"],
              ),
              title: Text(
                item["title"],
                style: TextStyle(color: item["color"], fontSize: 24),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
