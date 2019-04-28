import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

/// refer: https://medium.com/ux-in-motion/creating-usability-with-motion-the-ux-in-motion-manifesto-a87a4584ddc
/// https://proandroiddev.com/animations-in-flutter-6e02ee91a0b2
class UXAnimationRoute extends StatefulWidget {
  @override
  _UXAnimationRouteState createState() => _UXAnimationRouteState();
}

class _UXAnimationRouteState extends State<UXAnimationRoute>
    with SingleTickerProviderStateMixin {
  final pageIndexNotifier = ValueNotifier<int>(0);
  AnimationController _controller;
  Animation _animation;
  final tabs = [
    "Easing Animation",
    "Offset & Delay Animation",
    "Parenting Animation",
    "Transform & Masking",
    "ValueChange Animation"
  ];
  String _title;

  @override
  void initState() {
    super.initState();
    _title = tabs[0];
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 0.85).animate(_controller)
      ..addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      Positioned(
        top: 64,
        child: Opacity(
          opacity: _animation.value,
          child: Text(
            _title,
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 32),
          ),
        ),
      ),
      PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          pageIndexNotifier.value = index % tabs.length;
          _title = tabs[index % tabs.length];
          _controller.reset();
          _controller.forward();
        },
        itemBuilder: (context, index) {
          switch (index % tabs.length) {
            case 0:
              return EasingAnimationWidget();
              break;
            case 1:
              return OffsetDelayAnimationWidget();
              break;
            case 2:
              return ParentingAnimationWidget();
              break;
            case 3:
              return TransformMaskingAnimationWidget();
              break;
            case 4:
              return ValueChangeAnimationWidget();
              break;
          }
        },
      ),
      Positioned(
          bottom: 16,
          right: 16,
          child: RotatedBox(quarterTurns: 1, child: _buildPageViewIndicator()))
    ]));
  }

  Widget _buildPageViewIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: tabs.length,
      normalBuilder: (controller, index) => Circle(
            size: 8,
            color: Colors.black54,
          ),
      highlightedBuilder: (controller, index) => ScaleTransition(
            scale: CurvedAnimation(parent: controller, curve: Curves.ease),
            child: Circle(size: 12, color: Colors.black),
          ),
    );
  }
}

/// Build Easing Animation
class EasingAnimationWidget extends StatefulWidget {
  @override
  _EasingAnimationWidgetState createState() => _EasingAnimationWidgetState();
}

class _EasingAnimationWidgetState extends State<EasingAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ));
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.black12,
            ),
          ),
        );
      },
    );
  }
}

/// Build Offset & Delay Animation
class OffsetDelayAnimationWidget extends StatefulWidget {
  @override
  _OffsetDelayAnimationWidgetState createState() =>
      _OffsetDelayAnimationWidgetState();
}

class _OffsetDelayAnimationWidgetState extends State<OffsetDelayAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;
  Animation _lateAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addListener(() => setState(() {}))
      ..addStatusListener(handler);

    _lateAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.fastOutSlowIn,
        )))
      ..addListener(() => setState(() {}));
    _controller.forward();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ));
      _lateAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform(
          transform:
              Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
          child: Center(
            child: Container(
              width: 200,
              height: 50,
              color: Colors.black12,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Transform(
          transform:
              Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
          child: Center(
            child: Container(
              width: 200,
              height: 50,
              color: Colors.black12,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Transform(
          transform:
              Matrix4.translationValues(_lateAnimation.value * width, 0.0, 0.0),
          child: Center(
            child: Container(
              width: 200,
              height: 50,
              color: Colors.black12,
            ),
          ),
        )
      ],
    );
  }
}

/// Build Parenting Animation
class ParentingAnimationWidget extends StatefulWidget {
  @override
  _ParentingAnimationWidgetState createState() =>
      _ParentingAnimationWidgetState();
}

class _ParentingAnimationWidgetState extends State<ParentingAnimationWidget>
    with SingleTickerProviderStateMixin {
  Animation _growingAnimation;
  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _growingAnimation = Tween(begin: 10.0, end: 100.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            }
          });

    _animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Align(
            alignment: Alignment.center,
            child: Container(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Transform(
                        transform: Matrix4.translationValues(
                            _animation.value * width, 0.0, 0.0),
                        child: Center(
                            child: Center(
                                child: Container(
                                  height: _growingAnimation.value,
                                  width: _growingAnimation.value * 2,
                                  color: Colors.black12,
                                )))),
                    SizedBox(
                      height: 20,
                    ),
                    Transform(
                        transform: Matrix4.translationValues(
                            _animation.value * width, 0.0, 0.0),
                        child: Center(
                            child: Center(
                                child: Container(
                          height: 100,
                          width: 200,
                          color: Colors.black12,
                        )))),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

/// Build Transformation/Masking Animation
class TransformMaskingAnimationWidget extends StatefulWidget {
  @override
  _TransformMaskingAnimationWidgetState createState() =>
      _TransformMaskingAnimationWidgetState();
}

class _TransformMaskingAnimationWidgetState
    extends State<TransformMaskingAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation transitionAnimation;
  Animation borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) _controller.reverse();
          });

    transitionAnimation = Tween<double>(begin: 50, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    borderRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(75), end: BorderRadius.circular(0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Center(
            child: Stack(
              children: <Widget>[
                Center(
                    child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.black12,
                )),
                Center(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: transitionAnimation.value,
                    height: transitionAnimation.value,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: borderRadiusAnimation.value),
                  ),
                )
              ],
            ),
          ),
    );
  }
}

/// Build Value Change Animation
class ValueChangeAnimationWidget extends StatefulWidget {
  @override
  _ValueChangeAnimationWidgetState createState() =>
      _ValueChangeAnimationWidgetState();
}

class _ValueChangeAnimationWidgetState extends State<ValueChangeAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = IntTween(begin: 0, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse().orCancel;
            }
          });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Center(
        child: Text(_animation.value.toString(), style: TextStyle(fontSize: 48),),
      ),
    );
  }
}
