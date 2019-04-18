import 'package:flutter/material.dart';

/// 學習使用可讀取 GridView

class GridViewRoute extends StatefulWidget {
  @override
  _GridViewRouteState createState() => _GridViewRouteState();
}

class _GridViewRouteState extends State<GridViewRoute> with AutomaticKeepAliveClientMixin {
  List<IconData> _icons = [];
  final ScrollController _controller = ScrollController();
  var _showToTopBtn = false;

  @override
  void initState() {
    _retrieveIcons();
    _setupController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setupController() {
    _controller.addListener(() {
      if (_controller.offset < 1000 && _showToTopBtn) {
        setState(() => _showToTopBtn = false);
      } else if (_controller.offset >= 1000 && _showToTopBtn == false) {
        setState(() => _showToTopBtn = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !_showToTopBtn
          ? null
          : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _controller.animateTo(.0,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
      body: GridView.builder(
          controller: _controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
          itemCount: _icons.length,
          itemBuilder: (context, index) {
            if (_icons.length - 1 < 100) {
              _retrieveIcons();
            }
            return Card(child: Icon(_icons[index]));
          }),
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      _icons.addAll([
        Icons.ac_unit,
        Icons.airport_shuttle,
        Icons.all_inclusive,
        Icons.beach_access,
        Icons.cake,
        Icons.free_breakfast
      ]);
      if (this.mounted) setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
