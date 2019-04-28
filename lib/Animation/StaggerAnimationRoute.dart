import 'package:flutter/material.dart';
import 'Artist.dart';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'VideoCard.dart';

/// refer: https://iirokrankka.com/2018/03/14/orchestrating-multiple-animations-into-visual-enter-animation/

class StaggerAnimationRoute extends StatefulWidget {
  @override
  _StaggerAnimationRouteState createState() => _StaggerAnimationRouteState();
}

class _StaggerAnimationRouteState extends State<StaggerAnimationRoute> {
  @override
  Widget build(BuildContext context) {
    return ArtistDetailAnimator();
  }
}

/// Creating an AnimationController for the main animation
class ArtistDetailAnimator extends StatefulWidget {
  @override
  _ArtistDetailAnimatorState createState() => _ArtistDetailAnimatorState();
}

class _ArtistDetailAnimatorState extends State<ArtistDetailAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtistDetailsPage(
      artist: FakeData.superfly,
      controller: _controller,
    );
  }
}

/// Refactoring the ArtistDetailsPage to be animatable
class ArtistDetailsPage extends StatelessWidget {
  ArtistDetailsPage(
      {@required this.artist, @required AnimationController controller})
      : animation = ArtistDetailAnimation(controller);

  final Artist artist;
  final ArtistDetailAnimation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: animation.backdropOpacity.value,
          child: Image.asset(
            artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: animation.backdropBlur.value,
              sigmaY: animation.backdropBlur.value),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Transform(
      transform: Matrix4.diagonal3Values(
          animation.avatarSize.value, animation.avatarSize.value, 1),
      alignment: Alignment.center,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.white)),
        margin: EdgeInsets.only(top: 32, left: 16),
        padding: EdgeInsets.all(6),
        child: ClipOval(
          child: Image.asset(
            artist.avatar,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            artist.name,
            style: TextStyle(
                color: Colors.white.withOpacity(animation.nameOpacity.value),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          Text(
            artist.location,
            style: TextStyle(
                color:
                    Colors.white.withOpacity(animation.locationOpacity.value),
                fontWeight: FontWeight.w500),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            width: animation.dividerWidth.value,
            height: 1.0,
          ),
          Text(
            artist.biography,
            style: TextStyle(
                color:
                    Colors.white.withOpacity(animation.biographyOpacity.value),
                height: 1.5),
          )
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return Transform(
      transform: new Matrix4.translationValues(
        animation.videoScrollerXTranslation.value,
        0.0,
        0.0,
      ),
      child: Opacity(
        opacity: animation.videoScrollerOpacity.value,
        child: SizedBox.fromSize(
          size: Size.fromHeight(240),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: artist.videos.length,
              itemBuilder: (context, index) {
                return VideoCard(video: artist.videos[index]);
              }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: animation.controller, builder: _buildAnimation),
    );
  }
}

/// Creating the file for the animations
class ArtistDetailAnimation {
  ArtistDetailAnimation(this.controller)
      : backdropOpacity = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.500, curve: Curves.ease))),
        backdropBlur = Tween(begin: 0.0, end: 5.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.800, curve: Curves.ease))),
        avatarSize = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.100, 0.400, curve: Curves.elasticOut))),
        nameOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.350, 0.450, curve: Curves.easeIn))),
        locationOpacity = Tween(begin: 0.0, end: 0.85).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.500, 0.600, curve: Curves.easeIn))),
        dividerWidth = Tween(begin: 0.0, end: 225.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.650, 0.750, curve: Curves.fastOutSlowIn))),
        biographyOpacity = Tween(begin: 0.0, end: 0.85).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.750, 0.900, curve: Curves.easeIn))),
        videoScrollerXTranslation = Tween(begin: 60.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.890, 1.000, curve: Curves.ease))),
        videoScrollerOpacity = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.890, 1.000, curve: Curves.fastOutSlowIn)));

  final AnimationController controller;
  final Animation<double> backdropOpacity;
  final Animation<double> backdropBlur;
  final Animation<double> avatarSize;
  final Animation<double> nameOpacity;
  final Animation<double> locationOpacity;
  final Animation<double> dividerWidth;
  final Animation<double> biographyOpacity;
  final Animation<double> videoScrollerXTranslation;
  final Animation<double> videoScrollerOpacity;
}
