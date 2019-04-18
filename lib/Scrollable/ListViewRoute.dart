import 'package:flutter/material.dart';

/// 學習使用可讀取 ListView

class ListViewRoute extends StatefulWidget {
  @override
  _ListViewRouteState createState() => _ListViewRouteState();
}

class _ListViewRouteState extends State<ListViewRoute> with AutomaticKeepAliveClientMixin {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _retrieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("加載列表演示"),
          onTap: () => _scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.linear),
        ),
        Expanded(child: _createLoadableListView()),
      ],
    );
  }

  Widget _createLoadableListView() {
    return ListView.separated(
      itemCount: _words.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (_words[index] == loadingTag) {
          if (_words.length - 1 < 100) {
            _retrieveData();
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "No more",
                  style: TextStyle(color: Colors.grey),
                ));
          }
        }
        return ListTile(
          onTap: () {
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('This is item #${index + 1}'),
            ));
          },
          title: Text('${_words[index]}'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 4,
          color: Colors.grey,
        );
      },
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int x = _words.length - 1;

      for (var i = 1; i <= 20; i++) {
        _words.insert(_words.length - 1, 'Item #${x + i}');
      }
      if (this.mounted) setState(() {});
    });
  }


  @override
  bool get wantKeepAlive => true;
}
