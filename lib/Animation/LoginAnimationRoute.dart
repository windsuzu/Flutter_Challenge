import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

/// refer: https://blog.geekyants.com/flutter-login-animation-ab3e6ed4bd19

/// Login Screen
class LoginAnimationRoute extends StatefulWidget {
  @override
  _LoginAnimationRouteState createState() => _LoginAnimationRouteState();
}

class _LoginAnimationRouteState extends State<LoginAnimationRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  /// 按鈕縮小成旋轉指示的動畫
  Animation<double> buttonSqueezeAnimation;

  /// 按鈕放大佔滿螢幕的動畫
  Animation<double> buttonZoomout;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200))
      ..addListener(() {
        if (_controller.isCompleted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeAnimationRoute()));
        }
      });
    buttonSqueezeAnimation = Tween<double>(begin: 135, end: 20).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.250)));
    buttonZoomout = Tween<double>(begin: 70, end: 1000).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.55, 0.9, curve: Curves.bounceOut)));
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
      builder: (context, child) => Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.blue,
                    Colors.lightBlue[300],
                    Colors.lightBlueAccent
                  ])),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _divider(250),
                          _inputField(Icons.account_circle, "Username"),
                          _divider(8),
                          _inputField(Icons.lock, "Password", obscure: true),
                          _divider(64),
                          _signUpButton(),
                        ],
                      ),
                      _loginButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: Hero(
        tag: "fade",
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: buttonZoomout.value < 300
                  ? BorderRadius.circular(30)
                  : BorderRadius.zero),
          padding: EdgeInsets.symmetric(
              vertical: buttonZoomout.value == 70 ? 20 : buttonZoomout.value,
              horizontal: buttonZoomout.value == 70
                  ? buttonSqueezeAnimation.value
                  : buttonZoomout.value),
          color: Colors.pink[400],
          child: buttonSqueezeAnimation.value > 20
              ? Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: .3),
                )
              : buttonZoomout.value < 300
                  ? SizedBox(
                      width: 23,
                      height: 23,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : null,
          onPressed: () => _playAnimation(),
        ),
      ),
    );
  }

  Widget _inputField(IconData iconData, String labelText,
      {bool obscure = false}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          obscureText: obscure,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(
                iconData,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(16)),
        ));
  }

  Widget _signUpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.all(12),
            child: Text(
              "Don't have an account? Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
          )),
    );
  }

  Widget _divider(double height) {
    return SizedBox(
      height: height,
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward();
      await _controller.reverse();
    } on TickerCanceled {}
  }
}

/// Home Screen
class HomeAnimationRoute extends StatefulWidget {
  @override
  _HomeAnimationRouteState createState() => _HomeAnimationRouteState();
}

class _HomeAnimationRouteState extends State<HomeAnimationRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _fadeScreenAnimation;
  Animation _containerGrowAnimation;
  Animation _listTileWidthAnimation;
  Map<String, String> items = {
    "Back number": "Universal Sigma",
    "Mr.Children": "TOY'S FACTORY",
    "SPITZ": "Universal Music",
    "Kobukuro": "Warner Music",
    "Sukima Switch": "Ariola Japan",
  };
  var colors = [Colors.teal[200], Colors.purple[200], Colors.blueAccent[200]];
  AnimationController _buttonController;
  Animation _buttonBottomCenterAnimation;
  Animation _buttonZoomOutAnimation;

  @override
  void initState() {
    super.initState();

    /// Widgets for home screen start animation
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    /// Fade 進入 Home Screen 的動畫
    _fadeScreenAnimation = ColorTween(
            begin: Colors.pink[400], end: Colors.pink[400].withOpacity(0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
          ..addListener(() => setState(() {}));

    /// 各個 Widget 跟隨該動畫成長
    _containerGrowAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    /// ListTile 伸展出來的動畫
    _listTileWidthAnimation = Tween<double>(begin: 0, end: 64)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    /// Widgets for floating button clicking animation
    _buttonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addListener(() {
            if (_buttonController.isCompleted)
              Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondary) {
                return FadeTransition(
                  opacity: animation,
                  child: LoginAnimationRoute(),
                );
              }));
          });

    /// 當按下 button 先移到畫面中央
    _buttonBottomCenterAnimation =
        AlignmentTween(begin: Alignment.bottomRight, end: Alignment.center)
            .animate(CurvedAnimation(
                parent: _buttonController,
                curve: Interval(0.0, 0.4, curve: Curves.ease)));

    /// 一邊放大到佔滿全螢幕
    _buttonZoomOutAnimation = Tween<double>(begin: 64, end: 1000).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.ease));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _playButtonAnimation() {
    _buttonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: screenSize.width,
      height: screenSize.height,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          ListView(
            children: <Widget>[
              _profileBackground(),
              _listView(),
            ],
          ),
          _fadeBox(screenSize.width, screenSize.height),
          _floatingButton(),
        ],
      ),
    ));
  }

  Widget _profileBackground() {
    return Container(
      alignment: Alignment.center,
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepPurple[600], Colors.indigoAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.all(6),
              width: _containerGrowAnimation.value * 200,
              height: _containerGrowAnimation.value * 200,
              child: ClipOval(
                child:
                    Image.asset("images/avt_superfly.jpg", fit: BoxFit.cover),
              )),
          Container(
            alignment: Alignment.bottomCenter,
            height: 32,
            padding: EdgeInsets.all(16),
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 5,
                  fontSize: _containerGrowAnimation.value * 24),
            ),
          )
        ],
      ),
    );
  }

  Widget _listView() {
    var tiles = [];

    items.keys.toList().asMap().forEach((index, val) {
      tiles.add(Container(
        height: _listTileWidthAnimation.value,
        child: ListTile(
          onTap: () {},
          leading: CircleAvatar(
            backgroundColor: colors[index % 3],
            child: Text(
              "${val[0]}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          title: Text(val),
          subtitle: Text(items[val]),
        ),
      ));
    });

    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return tiles[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 8,
        );
      },
    );
  }

  Widget _floatingButton() {
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, animation) => Container(
            margin: _buttonZoomOutAnimation.value < 500
                ? EdgeInsets.only(right: 16, bottom: 16)
                : EdgeInsets.zero,
            alignment: _buttonBottomCenterAnimation.value,
            child: Container(
              alignment: _buttonBottomCenterAnimation.value,
              child: Material(
                shape: _buttonZoomOutAnimation.value < 500
                    ? CircleBorder()
                    : BeveledRectangleBorder(),
                elevation: 4,
                color: Colors.deepOrangeAccent,
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: _playButtonAnimation,
                  child: Container(
                      height: _containerGrowAnimation.value == 1
                          ? _buttonZoomOutAnimation.value
                          : _containerGrowAnimation.value * 64,
                      width: _containerGrowAnimation.value == 1
                          ? _buttonZoomOutAnimation.value
                          : _containerGrowAnimation.value * 64,
                      child: _buttonZoomOutAnimation.value < 100
                          ? Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          : null),
                ),
              ),
            ),
          ),
    );
  }

  Widget _fadeBox(double screenWidth, double screenHeight) {
    return Hero(
      tag: "fade",
      child: Container(
        width: _containerGrowAnimation.value < 1 ? screenWidth : 0.0,
        height: _containerGrowAnimation.value < 1 ? screenHeight : 0.0,
        decoration: BoxDecoration(color: _fadeScreenAnimation.value),
      ),
    );
  }
}
