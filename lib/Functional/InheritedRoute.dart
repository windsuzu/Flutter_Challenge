import 'package:flutter/material.dart';

/// 學習實現 InheritedWidget

/// Grandpa 定義模型
class ShareDataWidget extends InheritedWidget {
  final int data;

  ShareDataWidget({
    @required this.data,
    Widget child,
  })
      : assert(child != null),
        super(child: child);

  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}

/// Father 引入模型
class ChildWidget extends StatefulWidget {
  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ShareDataWidget(
      data: count,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TestWidget(),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme
                      .of(context)
                      .accentColor)),
              child: Text(
                'Increment',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => setState(() => count++),
            )
          ],
        ),
      ),
    );
  }
}

/// Child 跟著模型變動
class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ShareDataWidget
            .of(context)
            .data
            .toString(),
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    print("Dependencies change");
    super.didChangeDependencies();
  }
}
