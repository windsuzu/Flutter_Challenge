import 'package:flutter/material.dart';
import 'BoxDecorationRoute.dart';
import 'FlexRoute.dart';
import 'ContainerRoute.dart';
import 'StackRoute.dart';
import 'TransformRoute.dart';
import 'WrappedRowRoute.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flutter_challenge/generated/i18n.dart';

class LayoutRoute extends StatefulWidget {
  static const length = 6;

  @override
  _LayoutRouteState createState() => _LayoutRouteState();
}

class _LayoutRouteState extends State<LayoutRoute> {
  final pageIndexNotifier = ValueNotifier<int>(0);
  String title;

  @override
  Widget build(BuildContext context) {
    _changeTitle(pageIndexNotifier.value);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              top: 64,
              child: Text(
                "${title ?? ""}",
                style: Theme.of(context).textTheme.title,
              )),
          PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                _changeTitle(index % LayoutRoute.length);
                pageIndexNotifier.value = index % LayoutRoute.length;
              },
              itemBuilder: (context, index) {
                switch (index % LayoutRoute.length) {
                  case 0:
                    return Center(child: FlexRoute());
                    break;
                  case 1:
                    return Center(child: WrappedRowRoute());
                    break;
                  case 2:
                    return Center(child: StackRoute());
                    break;
                  case 3:
                    return Center(child: BoxDecorationRoute());
                    break;
                  case 4:
                    return Center(child: TransformRoute());
                    break;
                  case 5:
                    return Center(child: ContainerRoute());
                    break;
                }
                setState(() {});
              }),
          _createPageViewIndicator()
        ],
      ),
    );
  }

  void _changeTitle(int index) {
    switch (index) {
      case 0:
        title = S.of(context).flex;
        break;
      case 1:
        title = S.of(context).wrappedRow;
        break;
      case 2:
        title = S.of(context).stack;
        break;
      case 3:
        title = S.of(context).boxDecoration;
        break;
      case 4:
        title = S.of(context).transform;
        break;
      case 5:
        title = S.of(context).container;
        break;
    }
    setState(() {});
  }

  Widget _createPageViewIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: LayoutRoute.length,
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
