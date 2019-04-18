import 'package:flutter/material.dart';

/// 學習使用 Sliver

class SliverRoute extends StatefulWidget {
  @override
  _SliverRouteState createState() => _SliverRouteState();
}

class _SliverRouteState extends State<SliverRoute> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(16),
            title: Text(
              "Demo",
              style: TextStyle(color: Colors.white),
            ),
            background: Image.asset(
              'images/swan.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text(
                      'Grid Item $index',
                    ));
              }, childCount: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 4)),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: Text('List Item $index'),
            );
          }, childCount: 10),
          itemExtent: 100,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
