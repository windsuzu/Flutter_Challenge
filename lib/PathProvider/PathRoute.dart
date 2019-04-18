import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_challenge/generated/i18n.dart';

class PathRoute extends StatefulWidget {
  final String title;

  PathRoute({Key key, this.title}) : super(key: key);

  @override
  _PathRouteState createState() => _PathRouteState();
}

class _PathRouteState extends State<PathRoute> {
  int _counter = 0;

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

@override
  void initState() {
    _readCounter().then((val) {
      setState(() {
        _counter = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _incrementCounter,
        child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.of(context).push_text),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  )
                ],
              ),
            )),
      ),
    );
  }
}


