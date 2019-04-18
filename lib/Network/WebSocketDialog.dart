import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketDialog extends StatefulWidget {
  final channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  _WebSocketDialogState createState() => _WebSocketDialogState();
}

class _WebSocketDialogState extends State<WebSocketDialog> {
  var _text = "You have 3 seconds to click;";
  var count = 0;
  var _enable = true;

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              _text = "Network fails...";
            } else if (snapshot.hasData) {
              _text = "You clicked: " + snapshot.data + " times !!!";
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(_text),
            );
          },
        ),
        FlatButton(
          disabledColor: Colors.black38,
          disabledTextColor: Colors.white,
          shape: StadiumBorder(side: BorderSide(color: Colors.black54)),
          child:
          Text(_enable ? 'Click me as many as you can!!!' : "Time's up!"),
          onPressed: _enable == false
              ? null
              : () {
            if (count == 0) {
              Future.delayed(Duration(seconds: 3), () {
                widget.channel.sink.add(count.toString());
                count = 0;
                setState(() {
                  _enable = false;
                  Future.delayed(Duration(seconds: 1),
                          () => setState(() => _enable = true));
                });
              });
            }
            count += 1;
          },
        )
      ],
    );
  }
}
