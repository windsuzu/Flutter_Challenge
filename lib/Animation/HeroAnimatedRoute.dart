import 'package:flutter/material.dart';
import 'AnimatedImage.dart';

class HeroAnimatedRoute extends StatefulWidget {
  @override
  _HeroAnimatedRouteState createState() => _HeroAnimatedRouteState();
}

// 起點
class HeroListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Hero Animation"),
      trailing: Hero(
        tag: "bluejay",
        child: CircleAvatar(
          backgroundImage: Image
              .asset("images/bluejay.jpg")
              .image,
        ),
      ),
      onTap: () {
        _heroTransition(context);
      },
    );
  }

  void _heroTransition(BuildContext context) {
    Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation, secondary) {
      return FadeTransition(
        opacity: animation,
        child: HeroAnimatedRoute(),
      );
    }));
  }
}

// 終點
class _HeroAnimatedRouteState extends State<HeroAnimatedRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Image _image;
  List<Image> _images = [
    Image.asset(
      'images/bluejay.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'images/bluejay2.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'images/bluejay3.jpg',
      fit: BoxFit.cover,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _image = _images[0];
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 8,
            backgroundColor: Colors.transparent,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Blue Jay"),
              titlePadding: EdgeInsets.all(16),
              collapseMode: CollapseMode.parallax,
              background: AnimatedImage(
                animation: _animation,
                image: _image,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Blue Jay Photo ${index + 1}"),
                      onTap: () => _changeImage(index),
                    ),
                    Divider(
                      height: 8,
                      color: Colors.black54,
                    )
                  ],
                );
              }, childCount: 3),
              itemExtent: 64,
            ),
          )
        ],
      ),
    );
  }

  void _changeImage(int index) {
    _image = _images[index];
    _controller.reverse().whenComplete(() {
      setState(() {});
      _controller.forward();
    });
  }
}
