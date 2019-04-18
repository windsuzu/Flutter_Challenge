import 'package:flutter/material.dart';
import 'WebSocketDialog.dart';
import 'NetworkRequestDialog.dart';
import 'JsonDialog.dart';

class NetworkRoute extends StatefulWidget {
  @override
  _NetworkRouteState createState() => _NetworkRouteState();
}

class _NetworkRouteState extends State<NetworkRoute> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Request Google Home Page'),
              onPressed: () => _requestGoogleUsingDio(),
            ),
            RaisedButton(
              child: Text('Connect WebSocket'),
              onPressed: () => _connectWebSocket(),
            ),
            RaisedButton(
              child: Text('Get Json'),
              onPressed: () => _getJson(),
            ),
          ],
        ),
      ),
    );
  }

  void _requestGoogleUsingDio() async {
    showDialog(
        context: context,
        builder: (context) {
          return NetworkRequestDialog();
        });
  }

  void _connectWebSocket() {
    showDialog(
        context: context,
        builder: (context) {
          return WebSocketDialog();
        });
  }

  void _getJson() {
    showDialog(
        context: context,
        builder: (context) {
          return JsonDialog();
        });
  }
}
