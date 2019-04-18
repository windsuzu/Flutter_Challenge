import 'package:flutter/material.dart';
import 'package:flutter_challenge/generated/i18n.dart';
import 'GridViewRoute.dart';
import 'ListViewRoute.dart';
import 'SingleChildScrollViewRoute.dart';
import 'SliverRoute.dart';

class ScrollableRoute extends StatefulWidget {
  @override
  _ScrollableRouteState createState() => _ScrollableRouteState();
}

class _ScrollableRouteState extends State<ScrollableRoute>
    with SingleTickerProviderStateMixin {
  List tabs = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabs = [
      S.of(context).ScrollView,
      S.of(context).ListView,
      S.of(context).GridView,
      S.of(context).Sliver
    ];
    return Scaffold(
        appBar: TabBar(
            controller: _tabController,
            tabs: tabs.map((page) => Tab(text: page)).toList()),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((page) {
            if (page == S.of(context).ScrollView) {
              return SingleChildScrollViewRoute();
            }
            if (page == S.of(context).ListView) {
              return ListViewRoute();
            }
            if (page == S.of(context).GridView) {
              return GridViewRoute();
            }
            if (page == S.of(context).Sliver) {
              return SliverRoute();
            }
          }).toList(),
        ));
  }
}
